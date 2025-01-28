from firebase_functions import https_fn
from firebase_admin import initialize_app, messaging, auth, storage
from src.models.where import Where
from google.cloud import firestore

@https_fn.on_request()
def send_notification(req: https_fn.Request) -> https_fn.Response:
    try:
        data = req.get_json() or {}

        title = data.get('title', None)
        body = data.get('body', None)
        data_notification = data.get('data', None)
        notification_type = data.get('type', 'default')

        wheres_raw = data.get('wheres', [])
        wheres = [
            Where(
                field=w['field'],
                operator=w['operator'],
                value=w['value']
            )
            for w in wheres_raw
        ]

        if len(wheres) == 0:
            return https_fn.Response("No 'wheres' clauses provided.", status=400)

        db = firestore.Client()

        query = db.collection('users')
        for where in wheres:
            query = query.where(where.field, where.operator, where.value)

        users = query.get()

        if not users:
            return https_fn.Response("No users found matching the criteria.", status=404)

        tokens = []
        for user_doc in users:
            devices_ref = user_doc.reference.collection('devices')
            devices = devices_ref.get()

            for device_doc in devices:
                token = device_doc.get('fcmToken')
                if token:
                    tokens.append((token, user_doc.id))  # Pair token with user ID

        if not tokens:
            return https_fn.Response("No device tokens found.", status=404)

        messages = []
        for token, user_id in tokens:
            messages.append(
                messaging.Message(
                    data=data_notification,
                    token=token,
                    android=messaging.AndroidConfig(
                        priority='high',
                        notification=messaging.AndroidNotification(
                            title=title,
                            body=body,
                        ),
                    ),
                    apns=messaging.APNSConfig(
                        payload=messaging.APNSPayload(
                            aps=messaging.Aps(
                                alert=messaging.ApsAlert(
                                    title=title,
                                    body=body,
                                )
                            )
                        )
                    ),
                )
            )

        batch_response = messaging.send_each(messages)

        if title is not None and body is not None:
            for _, user_id in tokens:
                notifications_ref = db.collection('users').document(user_id).collection('notifications')
                notification_id = notifications_ref.document().id
                notification_data = {
                    'id': notification_id,
                    'title': title,
                    'body': body,
                    'type': notification_type,
                    'wasRead': False,
                    'data': data_notification,
                    'createdAt': firestore.SERVER_TIMESTAMP,
                    'updatedAt': firestore.SERVER_TIMESTAMP
                }
                notifications_ref.document(notification_id).set(notification_data)

        success_count = batch_response.success_count
        failure_count = batch_response.failure_count

        return https_fn.Response(
            f"Notifications sent. Success: {success_count}, Failures: {failure_count}"
        )

    except Exception as e:
        return https_fn.Response(f"Error sending notification: {str(e)}", status=500)
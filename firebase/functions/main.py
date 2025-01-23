from firebase_functions import https_fn
from firebase_admin import initialize_app, messaging, auth, storage
from src.models.where import Where
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives import serialization
import json
from google.cloud import firestore

initialize_app()


def response_to_json(data):
    return json.dumps(data)


@https_fn.on_request()
def hello_world(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")


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


@https_fn.on_request()
def generate_rsa_keys(req: https_fn.Request) -> https_fn.Response:
    try:
        # # Authenticate the user
        # id_token = req.headers.get("Authorization")
        # if not id_token:
        #     return https_fn.Response("Authorization token is required.", status=401)
        #
        # # Verify the ID token
        # decoded_token = auth.verify_id_token(id_token.split("Bearer ")[-1])
        # user_id = decoded_token.get("uid")

        user_id = "1234"

        if not user_id:
            return https_fn.Response("Invalid user ID.", status=401)

        # Generate RSA keys
        private_key = rsa.generate_private_key(
            public_exponent=65537,
            key_size=2048,
        )
        public_key = private_key.public_key()

        # Serialize keys
        private_key_pem = private_key.private_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PrivateFormat.PKCS8,
            encryption_algorithm=serialization.NoEncryption(),
        )

        public_key_pem = public_key.public_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PublicFormat.SubjectPublicKeyInfo,
        )

        # Save private key to Firebase Storage
        bucket = storage.bucket()
        private_key_blob = bucket.blob(f"rsa_keys/{user_id}__deviceId.pem")
        private_key_blob.upload_from_string(private_key_pem.decode("utf-8"))

        # Return the public key
        return https_fn.Response(
            response_to_json({'public_key': public_key_pem.decode("utf-8")}),
            # headers={"Content-Type": "application/json"},
            mimetype='application/json'
        )

    except Exception as e:
        return https_fn.Response(f"Error generating RSA keys: {str(e)}", status=500)


@https_fn.on_request()
def validate_keys(req: https_fn.Request) -> https_fn.Response:
    try:
        # Extract user ID and provided public key from the request
        data = req.get_json()
        if not data:
            return https_fn.Response("Invalid request payload.", status=400)

        user_id = data.get("user_id")
        provided_public_key = data.get("public_key")

        if not user_id or not provided_public_key:
            return https_fn.Response("User ID and public key are required.", status=400)

        # Retrieve the private key from Firebase Storage
        bucket = storage.bucket()
        private_key_blob = bucket.blob(f"rsa_keys/{user_id}__deviceId.pem")

        if not private_key_blob.exists():
            return https_fn.Response("Private key not found for the user ID.", status=404)

        private_key_pem = private_key_blob.download_as_string()

        # Load the private key
        private_key = serialization.load_pem_private_key(
            private_key_pem,
            password=None,
        )

        # Derive the public key
        public_key = private_key.public_key()

        # Serialize the derived public key to compare with the provided one
        derived_public_key_pem = public_key.public_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PublicFormat.SubjectPublicKeyInfo,
        ).decode("utf-8")

        # Validate the provided public key
        if provided_public_key.strip() == derived_public_key_pem.strip():
            return https_fn.Response(
                response_to_json({"status": "success", "message": "Public key is valid."}),
                mimetype="application/json",
            )
        else:
            return https_fn.Response(
                response_to_json({"status": "failure", "message": "Public key is invalid."}),
                mimetype="application/json",
                status=400,
            )

    except Exception as e:
        return https_fn.Response(f"Error validating public key: {str(e)}", status=500)

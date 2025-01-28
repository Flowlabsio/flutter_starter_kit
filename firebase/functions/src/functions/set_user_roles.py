from firebase_functions import https_fn
from firebase_admin import auth
from google.cloud import firestore


@https_fn.on_request()
def set_user_roles(req: https_fn.Request) -> https_fn.Response:
    """
    This function update user roles in Firebase Authentication and Firestore.
    It combines roles from the claims and ensures data consistency between Firestore.

    **Example cURL Command**:

    Emulator

    ```
    curl -X POST http://127.0.0.1:5001/<project-name>/<region>/set_user_roles \
    -H "Content-Type: application/json" \
    -d '{
        "id": "<user-id>",
        "roles": {"admin": true}
    }'
    ```

    Firebase

    ```
    curl -X https://<region>-<project-name>.cloudfunctions.net/<project-name>/<region>/set_user_roles \
    -H "Content-Type: application/json" \
    -d '{
        "id": "<user-id>",
        "roles": {"admin": true}
    }'
    ```
    """
    try:
        data = req.get_json()

        id = data.get("id")
        new_roles = data.get("roles")

        if not id or not new_roles:
            return https_fn.Response(
                "Missing 'id' or 'roles' in the request payload.",
                status=400,
            )

        user = auth.get_user(id)
        current_claims = user.custom_claims or {}
        current_roles = current_claims.get("roles", {})

        merged_roles = {**current_roles, **new_roles}

        updated_claims = {**current_claims, "roles": merged_roles}
        auth.set_custom_user_claims(id, updated_claims)

        try:
            db = firestore.Client()
            user_doc_ref = db.collection("users").document(id)
            user_doc_ref.set(
                {
                    "roles": merged_roles,
                    "updatedAt": firestore.SERVER_TIMESTAMP,
                },
                merge=True,
            )

            return https_fn.Response(
                f"Custom claims updated successfully for user {id}: {merged_roles} and saved to Firestore",
                status=200,
            )
        except Exception as firestore_error:
            auth.set_custom_user_claims(id, current_claims)

            return https_fn.Response(
                f"Firestore update failed. Custom claims rolled back. Error: {str(firestore_error)}",
                status=500,
            )

    except Exception as e:
        return https_fn.Response(
            f"Error processing the request: {str(e)}",
            status=500,
        )

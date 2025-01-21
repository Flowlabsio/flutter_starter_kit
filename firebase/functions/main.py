from firebase_functions import https_fn
from firebase_admin import initialize_app, messaging, auth, storage

from src.functions.send_notification import send_notification

initialize_app()


@https_fn.on_request()
def hello_world(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

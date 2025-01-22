from firebase_functions import https_fn
from firebase_admin import initialize_app

from src.functions.send_notification import send_notification
from src.functions.set_user_roles import set_user_roles

initialize_app()


@https_fn.on_request()
def hello_world(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

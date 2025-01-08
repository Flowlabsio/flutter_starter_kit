from typing import Union


class Device:
    def __init__(
            self,
            id: str,
            model: str,
            platform: str,
            fcm_token: Union[str, None]
    ) -> None:
        self.id = id
        self.model = model
        self.platform = platform
        self.fcm_token = fcm_token

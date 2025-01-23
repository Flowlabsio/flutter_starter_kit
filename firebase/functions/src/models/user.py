from typing import Union


class User:
    def __init__(
            self,
            id: str,
            firstName: str,
            lastName: str,
            email: str,
            photo: Union[str, None],
    ) -> None:
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.photo = photo

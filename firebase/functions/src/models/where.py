from typing import Union


class Where:
    def __init__(
            self,
            field: str,
            operator: str,
            value: Union[str, int, float, bool, None],
    ) -> None:
        self.field = field
        self.operator = operator
        self.value = value

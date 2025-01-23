class CustomException implements Exception {
  CustomException([this.message = '']);

  final String message;
}

class CancelOperation extends CustomException {
  CancelOperation([super.message]);
}

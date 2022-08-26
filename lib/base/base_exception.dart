class BaseException implements Exception {
  final dynamic message;

  BaseException([this.message]);

  String toString() {
    String message = this.message;

    if (message.isEmpty) return "codeBadRequest";
    return "$message";
  }
}

class UnAuthException implements Exception {
  UnAuthException();
}
class ForbiddenException implements Exception {
  ForbiddenException();
}
class BadRequestException implements Exception {
  BadRequestException();
}
class NotFoundException implements Exception {
  NotFoundException();
}
class BadGatewayException implements Exception {
  BadGatewayException();
}

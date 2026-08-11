// lib/core/errors/exceptions.dart
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
}

class NetworkException implements Exception {
  const NetworkException();
}

class UnauthorizedException implements Exception {
  const UnauthorizedException();
}

class ValidationException implements Exception {
  final Map<String, List<String>> errors;
  const ValidationException(this.errors);
}

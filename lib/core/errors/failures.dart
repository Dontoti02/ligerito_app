// lib/core/errors/failures.dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Sin conexión a internet');
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>> errors;
  const ValidationFailure(this.errors) : super('Error de validación');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Sesión expirada');
}

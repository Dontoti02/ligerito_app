// test/core/errors/failures_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/errors/failures.dart';

void main() {
  group('NetworkFailure', () {
    test('tiene mensaje por defecto', () {
      expect(const NetworkFailure().message, 'Sin conexión a internet');
    });
  });

  group('ServerFailure', () {
    test('retorna el mensaje proporcionado', () {
      expect(const ServerFailure('Timeout').message, 'Timeout');
    });
  });

  group('ValidationFailure', () {
    test('tiene mensaje fijo y mapa de errores', () {
      final errors = {'email': ['Requerido']};
      final f = ValidationFailure(errors);
      expect(f.message, 'Error de validación');
      expect(f.errors, errors);
    });
  });

  group('UnauthorizedFailure', () {
    test('tiene mensaje de sesión expirada', () {
      expect(const UnauthorizedFailure().message, 'Sesión expirada');
    });
  });
}

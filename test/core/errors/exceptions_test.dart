// test/core/errors/exceptions_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/errors/exceptions.dart';

void main() {
  group('ServerException', () {
    test('retorna message y statusCode', () {
      final e = ServerException('Not found', statusCode: 404);
      expect(e.message, 'Not found');
      expect(e.statusCode, 404);
    });

    test('statusCode es null por defecto', () {
      expect(ServerException('err').statusCode, isNull);
    });
  });

  group('NetworkException', () {
    test('se instancia sin parámetros', () {
      expect(const NetworkException(), isA<Exception>());
    });
  });

  group('UnauthorizedException', () {
    test('se instancia sin parámetros', () {
      expect(const UnauthorizedException(), isA<Exception>());
    });
  });

  group('ValidationException', () {
    test('retorna el mapa de errores', () {
      final errors = {'campo': ['error1']};
      final e = ValidationException(errors);
      expect(e.errors, errors);
    });
  });
}

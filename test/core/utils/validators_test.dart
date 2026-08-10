// test/core/utils/validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/utils/validators.dart';

void main() {
  group('LigeritoValidators.telefono', () {
    test('rechaza vacío', () {
      expect(LigeritoValidators.telefono(''), isNotNull);
      expect(LigeritoValidators.telefono(null), isNotNull);
    });
    test('rechaza 8 dígitos', () {
      expect(LigeritoValidators.telefono('98765432'), isNotNull);
    });
    test('rechaza si no empieza con 9', () {
      expect(LigeritoValidators.telefono('187654321'), isNotNull);
    });
    test('rechaza letras', () {
      expect(LigeritoValidators.telefono('9abcdefgh'), isNotNull);
    });
    test('acepta 9 dígitos empezando con 9', () {
      expect(LigeritoValidators.telefono('987654321'), isNull);
    });
  });

  group('LigeritoValidators.password', () {
    test('rechaza menos de 6 caracteres', () {
      expect(LigeritoValidators.password('12345'), isNotNull);
    });
    test('rechaza null', () {
      expect(LigeritoValidators.password(null), isNotNull);
    });
    test('acepta 6+ caracteres', () {
      expect(LigeritoValidators.password('123456'), isNull);
    });
  });

  group('LigeritoValidators.nombreObligatorio', () {
    test('rechaza vacío o solo espacios', () {
      expect(LigeritoValidators.nombreObligatorio(''), isNotNull);
      expect(LigeritoValidators.nombreObligatorio('   '), isNotNull);
    });
    test('acepta nombre', () {
      expect(LigeritoValidators.nombreObligatorio('Juan'), isNull);
    });
  });

  group('LigeritoValidators.precioPositivo', () {
    test('rechaza 0', () {
      expect(LigeritoValidators.precioPositivo('0'), isNotNull);
    });
    test('rechaza negativo', () {
      expect(LigeritoValidators.precioPositivo('-5'), isNotNull);
    });
    test('rechaza texto', () {
      expect(LigeritoValidators.precioPositivo('abc'), isNotNull);
    });
    test('acepta decimal positivo', () {
      expect(LigeritoValidators.precioPositivo('12.50'), isNull);
    });
  });
}

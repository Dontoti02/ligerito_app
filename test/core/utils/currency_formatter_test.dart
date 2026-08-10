// test/core/utils/currency_formatter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter.formatoPen', () {
    test('formatea centavos a soles con punto decimal', () {
      expect(CurrencyFormatter.formatoPen(2590), 'S/ 25.90');
    });

    test('cero', () {
      expect(CurrencyFormatter.formatoPen(0), 'S/ 0.00');
    });

    test('miles con separador de coma', () {
      expect(CurrencyFormatter.formatoPen(125000), 'S/ 1,250.00');
    });

    test('redondea centavos exactos sin decimales de más', () {
      expect(CurrencyFormatter.formatoPen(1000), 'S/ 10.00');
    });

    test('un centavo', () {
      expect(CurrencyFormatter.formatoPen(1), 'S/ 0.01');
    });
  });
}

// test/core/utils/date_formatter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/utils/date_formatter.dart';

void main() {
  final ahora = DateTime(2026, 8, 9, 12, 0, 0);

  group('DateFormatter.tiempoTranscurrido', () {
    test('menos de 1 minuto es "ahora mismo"', () {
      expect(
        DateFormatter.tiempoTranscurrido(
          ahora.subtract(const Duration(seconds: 30)),
          ahora: ahora,
        ),
        'ahora mismo',
      );
    });

    test('minutos', () {
      expect(
        DateFormatter.tiempoTranscurrido(
          ahora.subtract(const Duration(minutes: 5)),
          ahora: ahora,
        ),
        'hace 5 min',
      );
    });

    test('horas', () {
      expect(
        DateFormatter.tiempoTranscurrido(
          ahora.subtract(const Duration(hours: 3)),
          ahora: ahora,
        ),
        'hace 3 h',
      );
    });

    test('un día es "ayer"', () {
      expect(
        DateFormatter.tiempoTranscurrido(
          ahora.subtract(const Duration(days: 1)),
          ahora: ahora,
        ),
        'ayer',
      );
    });

    test('varios días', () {
      expect(
        DateFormatter.tiempoTranscurrido(
          ahora.subtract(const Duration(days: 4)),
          ahora: ahora,
        ),
        'hace 4 días',
      );
    });
  });
}

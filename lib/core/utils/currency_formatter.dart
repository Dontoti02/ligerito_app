// lib/core/utils/currency_formatter.dart
import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _format = NumberFormat('#,##0.00', 'en_US');

  /// Convierte centavos (int) a "S/ 25.90".
  /// ÚNICO lugar donde se formatea dinero (regla de la sección 4).
  static String formatoPen(int centavos) => 'S/ ${_format.format(centavos / 100)}';
}

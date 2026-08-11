// lib/core/utils/date_formatter.dart
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String fechaHora(DateTime dt) =>
      DateFormat('dd/MM/yyyy hh:mm a', 'es_PE').format(dt);

  static String tiempoTranscurrido(DateTime desde, {DateTime? ahora}) {
    final diff = (ahora ?? DateTime.now()).difference(desde);
    if (diff.inMinutes < 1) return 'ahora mismo';
    if (diff.inMinutes < 60) return 'hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'hace ${diff.inHours} h';
    if (diff.inDays == 1) return 'ayer';
    return 'hace ${diff.inDays} días';
  }
}

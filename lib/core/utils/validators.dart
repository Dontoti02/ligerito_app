// lib/core/utils/validators.dart
class LigeritoValidators {
  LigeritoValidators._();

  /// Teléfono peruano móvil: 9 dígitos, empieza con 9 (criterio 8.1).
  static String? telefono(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa tu teléfono';
    if (!RegExp(r'^9\d{8}$').hasMatch(v)) {
      return 'Teléfono inválido: 9 dígitos y empieza con 9';
    }
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? nombreObligatorio(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Este campo es obligatorio';
    return null;
  }

  static String? precioPositivo(String? value) {
    final parsed = double.tryParse(value ?? '');
    if (parsed == null) return 'Ingresa un precio válido';
    if (parsed <= 0) return 'El precio debe ser mayor a 0';
    return null;
  }
}

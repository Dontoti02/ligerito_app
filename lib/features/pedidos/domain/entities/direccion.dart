// lib/features/pedidos/domain/entities/direccion.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'direccion.freezed.dart';

@freezed
class Direccion with _$Direccion {
  const factory Direccion({
    required String id,
    required String etiqueta,
    required String direccionTexto,
    required double lat,
    required double lng,
    String? referencia,
  }) = _Direccion;
}

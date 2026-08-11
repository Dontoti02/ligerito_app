// lib/features/catalogo/domain/entities/producto.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'producto.freezed.dart';

@freezed
class Producto with _$Producto {
  const factory Producto({
    required String id,
    required String negocioId,
    required String nombre,
    String? descripcion,
    required int precioEnCentavos,
    String? imagenUrl,
    required bool disponible,
    String? seccionMenu,
  }) = _Producto;
}

// lib/features/carrito/domain/entities/item_carrito.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

part 'item_carrito.freezed.dart';

@freezed
class ItemCarrito with _$ItemCarrito {
  const ItemCarrito._();

  const factory ItemCarrito({
    required Producto producto,
    required int cantidad,
    String? notas,
  }) = _ItemCarrito;

  int get subtotalEnCentavos => producto.precioEnCentavos * cantidad;
}

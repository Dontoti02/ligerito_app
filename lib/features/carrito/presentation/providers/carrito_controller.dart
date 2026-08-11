import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/carrito/domain/entities/resultado_agregar.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'carrito_controller.freezed.dart';
part 'carrito_controller.g.dart';

@freezed
class CarritoState with _$CarritoState {
  const factory CarritoState({
    @Default([]) List<ItemCarrito> items,
    String? negocioId,
    String? negocioNombre,
  }) = _CarritoState;
}

@Riverpod(keepAlive: true)
class CarritoController extends _$CarritoController {
  @override
  CarritoState build() => const CarritoState();

  ResultadoAgregar agregar(Producto producto, {String? negocioNombre}) {
    final current = state;
    if (current.negocioId != null && current.negocioId != producto.negocioId) {
      return ResultadoAgregar.conflictoNegocio;
    }
    final items = List<ItemCarrito>.from(current.items);
    final idx = items.indexWhere((i) => i.producto.id == producto.id);
    if (idx >= 0) {
      items[idx] = items[idx].copyWith(cantidad: items[idx].cantidad + 1);
    } else {
      items.add(ItemCarrito(producto: producto, cantidad: 1));
    }
    state = current.copyWith(
      items: items,
      negocioId: producto.negocioId,
      negocioNombre: negocioNombre,
    );
    return ResultadoAgregar.agregado;
  }

  void cambiarCantidad(String productoId, int cantidad) {
    final current = state;
    if (cantidad <= 0) {
      eliminarItem(productoId);
      return;
    }
    final items = current.items.map((i) {
      if (i.producto.id == productoId) {
        return i.copyWith(cantidad: cantidad);
      }
      return i;
    }).toList();
    state = current.copyWith(items: items);
  }

  void eliminarItem(String productoId) {
    final current = state;
    final items = current.items.where((i) => i.producto.id != productoId).toList();
    if (items.isEmpty) {
      state = const CarritoState();
    } else {
      state = current.copyWith(items: items);
    }
  }

  void vaciar() {
    state = const CarritoState();
  }

  int get subtotalEnCentavos =>
      state.items.fold(0, (sum, i) => sum + i.subtotalEnCentavos);
}

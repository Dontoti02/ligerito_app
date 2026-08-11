// lib/features/pedidos/domain/entities/pedido.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';

part 'pedido.freezed.dart';

@freezed
class Pedido with _$Pedido {
  const factory Pedido({
    required String id,
    required String negocioId,
    required List<ItemCarrito> items,
    required EstadoPedido estado,
    required MetodoPago metodoPago,
    required int subtotalEnCentavos,
    required int costoEnvioEnCentavos,
    required int totalEnCentavos,
    required Direccion direccionEntrega,
    required DateTime creadoEn,
    // Para el card de pedido entrante del panel negocio (criterio 8.5).
    String? clienteNombre,
    String? clienteTelefono,
  }) = _Pedido;
}

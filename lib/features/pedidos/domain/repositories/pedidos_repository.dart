import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';

abstract class PedidosRepository {
  Future<List<Pedido>> getMisPedidos();
  Future<Pedido?> getPedido(String id);
  Future<Pedido> crearPedido(Pedido pedido);
  Future<void> actualizarEstado(String id, EstadoPedido estado);
}

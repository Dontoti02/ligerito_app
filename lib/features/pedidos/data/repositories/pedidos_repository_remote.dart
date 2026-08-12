import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/features/pedidos/data/models/pedidos_dtos.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/repositories/pedidos_repository.dart';

class PedidosRepositoryRemote implements PedidosRepository {
  final Dio _dio;

  PedidosRepositoryRemote(this._dio);

  @override
  Future<List<Pedido>> getMisPedidos() async {
    final response = await _dio.get(ApiEndpoints.pedidos, queryParameters: {'per_page': 100});
    final data = response.data['data'] as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;
    return items
        .map((j) => PedidoDto.fromJson(j as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Pedido?> getPedido(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.pedidoDetalle(id));
      final data = response.data['data'] as Map<String, dynamic>;
      return PedidoDto.fromJson(data).toEntity();
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<Pedido> crearPedido(Pedido pedido) async {
    final itemsData = pedido.items.map((item) {
      return {
        'producto_id': int.tryParse(item.producto.id) ?? item.producto.id,
        'cantidad': item.cantidad,
        if (item.notas != null && item.notas!.isNotEmpty) 'notas': item.notas,
      };
    }).toList();

    final response = await _dio.post(ApiEndpoints.pedidos, data: {
      'negocio_id': int.tryParse(pedido.negocioId) ?? pedido.negocioId,
      'items': itemsData,
      'direccion_entrega_id': int.tryParse(pedido.direccionEntrega.id) ?? pedido.direccionEntrega.id,
      'metodo_pago': pedido.metodoPago.name,
    });

    final data = response.data['data'] as Map<String, dynamic>;
    return PedidoDto.fromJson(data).toEntity();
  }

  @override
  Future<void> actualizarEstado(String id, EstadoPedido estado) async {
    await _dio.patch(
      ApiEndpoints.pedidoEstado(id),
      data: {'estado': estado.name},
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/features/pedidos/data/repositories/pedidos_repository_mock.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/repositories/pedidos_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pedidos_providers.g.dart';

@Riverpod(keepAlive: true)
PedidosRepository pedidosRepository(Ref ref) => PedidosRepositoryMock();

@riverpod
Future<List<Pedido>> misPedidos(Ref ref) {
  final repo = ref.watch(pedidosRepositoryProvider);
  return repo.getMisPedidos();
}

@riverpod
Future<Pedido?> pedidoDetalle(Ref ref, String id) {
  final repo = ref.watch(pedidosRepositoryProvider);
  return repo.getPedido(id);
}

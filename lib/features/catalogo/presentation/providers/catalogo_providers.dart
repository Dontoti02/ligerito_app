import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/network/providers/dio_providers.dart';
import 'package:ligerito/features/catalogo/data/repositories/catalogo_repository_remote.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalogo_providers.g.dart';

@Riverpod(keepAlive: true)
CatalogoRepository catalogoRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return CatalogoRepositoryRemote(dio);
}

@riverpod
Future<List<Negocio>> negocios(Ref ref) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getNegocios();
}

@riverpod
Future<Negocio?> negocio(Ref ref, String id) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getNegocio(id);
}

@riverpod
Future<List<Producto>> productosNegocio(Ref ref, String negocioId) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getProductosByNegocio(negocioId);
}

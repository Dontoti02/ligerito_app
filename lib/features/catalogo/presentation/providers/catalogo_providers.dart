// lib/features/catalogo/presentation/providers/catalogo_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/features/catalogo/data/repositories/catalogo_repository_mock.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalogo_providers.g.dart';

@Riverpod(keepAlive: true)
CatalogoRepository catalogoRepository(Ref ref) => CatalogoRepositoryMock();

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

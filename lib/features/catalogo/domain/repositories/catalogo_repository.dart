// lib/features/catalogo/domain/repositories/catalogo_repository.dart
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

abstract class CatalogoRepository {
  Future<List<Negocio>> getNegocios();
  Future<Negocio?> getNegocio(String id);
  Future<List<Producto>> getProductosByNegocio(String negocioId);
}

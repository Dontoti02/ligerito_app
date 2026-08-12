import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/features/catalogo/data/models/catalogo_dtos.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';

class CatalogoRepositoryRemote implements CatalogoRepository {
  final Dio _dio;

  CatalogoRepositoryRemote(this._dio);

  @override
  Future<List<Negocio>> getNegocios() async {
    final response = await _dio.get(ApiEndpoints.negocios, queryParameters: {'per_page': 100});
    final data = response.data['data'] as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;
    return items
        .map((j) => NegocioDto.fromJson(j as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Negocio?> getNegocio(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.negocioDetalle(id));
      final data = response.data['data'] as Map<String, dynamic>;
      return NegocioDto.fromJson(data['negocio'] as Map<String, dynamic>).toEntity();
    } on DioException catch (_) {
      return null;
    }
  }

  @override
  Future<List<Producto>> getProductosByNegocio(String negocioId) async {
    try {
      final response = await _dio.get(ApiEndpoints.negocioDetalle(negocioId));
      final data = response.data['data'] as Map<String, dynamic>;
      final menu = data['menu'] as Map<String, dynamic>;
      final productos = <Producto>[];
      menu.forEach((seccion, items) {
        for (final item in items as List<dynamic>) {
          productos.add(
            ProductoDto.fromJson(item as Map<String, dynamic>).toEntity(),
          );
        }
      });
      return productos;
    } on DioException catch (_) {
      return [];
    }
  }
}

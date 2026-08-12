import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/features/catalogo/data/models/catalogo_dtos.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/repositories/direcciones_repository.dart';

class DireccionesRepositoryRemote implements DireccionesRepository {
  final Dio _dio;

  DireccionesRepositoryRemote(this._dio);

  @override
  Future<List<Direccion>> getDirecciones() async {
    final response = await _dio.get(ApiEndpoints.direcciones);
    final data = response.data['data'] as Map<String, dynamic>;
    final items = data['data'] as List<dynamic>;
    return items
        .map((j) => DireccionDto.fromJson(j as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Direccion> crear(Direccion direccion) async {
    final response = await _dio.post(ApiEndpoints.direcciones, data: {
      'etiqueta': direccion.etiqueta,
      'direccion_texto': direccion.direccionTexto,
      'lat': direccion.lat,
      'lng': direccion.lng,
      if (direccion.referencia != null) 'referencia': direccion.referencia,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return DireccionDto.fromJson(data).toEntity();
  }

  @override
  Future<Direccion> actualizar(Direccion direccion) async {
    final response = await _dio.put(
      ApiEndpoints.direccionDetalle(direccion.id),
      data: {
        'etiqueta': direccion.etiqueta,
        'direccion_texto': direccion.direccionTexto,
        'lat': direccion.lat,
        'lng': direccion.lng,
        if (direccion.referencia != null) 'referencia': direccion.referencia,
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return DireccionDto.fromJson(data).toEntity();
  }

  @override
  Future<void> eliminar(String id) async {
    await _dio.delete(ApiEndpoints.direccionDetalle(id));
  }
}

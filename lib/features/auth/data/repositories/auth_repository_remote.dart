import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/core/errors/exceptions.dart';
import 'package:ligerito/core/errors/failures.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/core/storage/secure_storage_service.dart';
import 'package:ligerito/features/auth/data/models/auth_dtos.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryRemote implements AuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;

  AuthRepositoryRemote(this._dio, this._storage);

  @override
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  }) async {
    try {
      final response = await _dio.post(ApiEndpoints.login, data: {
        'telefono': telefono,
        'password': password,
      });

      final data = response.data['data'] as Map<String, dynamic>;
      final authDto = AuthLoginResponseDto.fromJson(data);
      await _storage.guardarTokens(
        accessToken: authDto.accessToken,
        refreshToken: authDto.refreshToken,
      );
      return ApiSuccess(authDto.usuario.toEntity());
    } on DioException catch (e) {
      final failure = switch (e.error) {
        NetworkException() => const NetworkFailure(),
        ServerException(:final message) => ServerFailure(message),
        ValidationException(:final errors) =>
          ServerFailure(errors.values.first.first),
        _ => const ServerFailure('Teléfono o contraseña incorrectos'),
      };
      return ApiError(failure);
    }
  }

  @override
  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) async {
    try {
      final response = await _dio.post(ApiEndpoints.register, data: {
        'nombre': nombre,
        'telefono': telefono,
        'password': password,
        if (email != null) 'email': email,
      });

      final data = response.data['data'] as Map<String, dynamic>;
      final authDto = AuthRegisterResponseDto.fromJson(data);
      await _storage.guardarTokens(
        accessToken: authDto.accessToken,
        refreshToken: authDto.refreshToken,
      );
      return ApiSuccess(authDto.usuario.toEntity());
    } on DioException catch (e) {
      final failure = switch (e.error) {
        NetworkException() => const NetworkFailure(),
        ServerException(:final message) => ServerFailure(message),
        ValidationException(:final errors) =>
          ServerFailure(errors.values.first.first),
        _ => ServerFailure(e.response?.data?['message'] ?? 'Error al registrar'),
      };
      return ApiError(failure);
    }
  }

  @override
  Future<void> cerrarSesion() async {
    try {
      await _dio.post(ApiEndpoints.logout);
    } catch (_) {}
    await _storage.limpiar();
  }
}

// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/core/network/interceptors/auth_interceptor.dart';
import 'package:ligerito/core/network/interceptors/error_interceptor.dart';
import 'package:ligerito/core/storage/secure_storage_service.dart';

Dio buildDioClient(
  SecureStorageService storage, {
  required Future<void> Function() onSesionExpirada,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(storage),
    ErrorInterceptor(onSesionExpirada: onSesionExpirada),
  ]);
  return dio;
}

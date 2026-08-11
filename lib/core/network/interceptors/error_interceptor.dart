// lib/core/network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:ligerito/core/errors/exceptions.dart';

/// Traduce DioException a excepciones de dominio de forma centralizada.
/// 401 dispara [onSesionExpirada] (refresh/logout lo conecta la sesión).
class ErrorInterceptor extends Interceptor {
  final Future<void> Function() onSesionExpirada;

  ErrorInterceptor({required this.onSesionExpirada});

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: const NetworkException(),
      ));
    }

    if (status == 401) {
      await onSesionExpirada();
      return handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: const UnauthorizedException(),
      ));
    }

    if (status == 422) {
      final raw = err.response?.data;
      final errors = (raw is Map ? raw['errors'] : null) is Map
          ? (raw['errors'] as Map).map(
              (k, v) => MapEntry(k.toString(), List<String>.from(v as List)),
            )
          : <String, List<String>>{};
      return handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ValidationException(errors),
      ));
    }

    final data = err.response?.data;
    final message =
        (data is Map ? data['message']?.toString() : null) ?? 'Error del servidor';
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: ServerException(message, statusCode: status),
    ));
  }
}

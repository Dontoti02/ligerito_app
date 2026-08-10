// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  });

  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  });

  Future<void> cerrarSesion();
}

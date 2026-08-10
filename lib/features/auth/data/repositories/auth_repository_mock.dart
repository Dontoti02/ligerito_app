// lib/features/auth/data/repositories/auth_repository_mock.dart
import 'package:ligerito/core/errors/failures.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

/// Mock de Fase 0: simula delay de API y retorna datos fake.
/// Credenciales válidas: teléfono 9 dígitos (empieza con 9) + password ≥ 6 chars.
/// Teléfonos 90/91/92 → rol negocio; otros → rol cliente.
class AuthRepositoryMock implements AuthRepository {
  @override
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (password.length < 6) {
      return const ApiError(ServerFailure('Teléfono o contraseña incorrectos'));
    }

    final esNegocio = telefono.startsWith('90') ||
        telefono.startsWith('91') ||
        telefono.startsWith('92');

    return ApiSuccess(Usuario(
      id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
      nombre: esNegocio ? 'Mi Negocio' : 'Cliente Demo',
      telefono: telefono,
      rol: esNegocio ? RolUsuario.negocio : RolUsuario.cliente,
    ));
  }

  @override
  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return ApiSuccess(Usuario(
      id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
      nombre: nombre,
      telefono: telefono,
      email: email,
      rol: RolUsuario.cliente,
    ));
  }

  @override
  Future<void> cerrarSesion() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

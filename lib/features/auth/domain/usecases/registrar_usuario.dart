// lib/features/auth/domain/usecases/registrar_usuario.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class RegistrarUsuario {
  final AuthRepository _repository;

  const RegistrarUsuario(this._repository);

  Future<ApiResult<Usuario>> call({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) {
    return _repository.registrar(
      nombre: nombre,
      telefono: telefono,
      password: password,
      email: email,
    );
  }
}

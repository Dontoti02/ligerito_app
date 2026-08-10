// lib/features/auth/domain/usecases/iniciar_sesion.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class IniciarSesion {
  final AuthRepository _repository;

  const IniciarSesion(this._repository);

  Future<ApiResult<Usuario>> call({
    required String telefono,
    required String password,
  }) {
    return _repository.iniciarSesion(telefono: telefono, password: password);
  }
}

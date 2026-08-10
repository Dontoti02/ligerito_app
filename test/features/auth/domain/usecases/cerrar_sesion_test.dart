// test/features/auth/domain/usecases/cerrar_sesion_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligerito/features/auth/domain/usecases/cerrar_sesion.dart';

class FakeAuthRepository implements AuthRepository {
  bool cerrarLlamado = false;

  @override
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  }) async => throw UnimplementedError();

  @override
  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) async => throw UnimplementedError();

  @override
  Future<void> cerrarSesion() async {
    cerrarLlamado = true;
  }
}

void main() {
  test('ejecuta cerrarSesion en repository', () async {
    final repo = FakeAuthRepository();
    final usecase = CerrarSesion(repo);
    await usecase();
    expect(repo.cerrarLlamado, isTrue);
  });
}

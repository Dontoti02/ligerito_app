// test/features/auth/domain/usecases/registrar_usuario_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligerito/features/auth/domain/usecases/registrar_usuario.dart';

class FakeAuthRepository implements AuthRepository {
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
  }) async {
    return ApiSuccess(Usuario(
      id: 'u2',
      nombre: nombre,
      telefono: telefono,
      email: email,
      rol: RolUsuario.cliente,
    ));
  }

  @override
  Future<void> cerrarSesion() async => throw UnimplementedError();
}

void main() {
  late RegistrarUsuario usecase;

  setUp(() {
    usecase = RegistrarUsuario(FakeAuthRepository());
  });

  test('retorna usuario registrado con datos correctos', () async {
    final result = await usecase(
      nombre: 'Ana',
      telefono: '987654321',
      password: 'abcdef',
      email: 'ana@test.com',
    );
    expect(result, isA<ApiSuccess<Usuario>>());
    final usuario = (result as ApiSuccess<Usuario>).data;
    expect(usuario.nombre, 'Ana');
    expect(usuario.email, 'ana@test.com');
    expect(usuario.rol, RolUsuario.cliente);
  });

  test('funciona sin email', () async {
    final result = await usecase(
      nombre: 'Pedro',
      telefono: '912345678',
      password: '123456',
    );
    final usuario = (result as ApiSuccess<Usuario>).data;
    expect(usuario.email, isNull);
  });
}

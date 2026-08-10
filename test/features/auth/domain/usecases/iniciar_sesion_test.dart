// test/features/auth/domain/usecases/iniciar_sesion_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/errors/failures.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligerito/features/auth/domain/usecases/iniciar_sesion.dart';

class FakeAuthRepository implements AuthRepository {
  bool shouldFail = false;

  @override
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  }) async {
    if (shouldFail) {
      return const ApiError(ServerFailure('Credenciales inválidas'));
    }
    return ApiSuccess(Usuario(
      id: 'u1',
      nombre: 'Test',
      telefono: telefono,
      rol: RolUsuario.cliente,
    ));
  }

  @override
  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) async => throw UnimplementedError();

  @override
  Future<void> cerrarSesion() async => throw UnimplementedError();
}

void main() {
  late FakeAuthRepository repo;
  late IniciarSesion usecase;

  setUp(() {
    repo = FakeAuthRepository();
    usecase = IniciarSesion(repo);
  });

  test('delega al repository y retorna éxito', () async {
    final result = await usecase(
      telefono: '987654321',
      password: '123456',
    );
    expect(result, isA<ApiSuccess<Usuario>>());
    expect((result as ApiSuccess<Usuario>).data.telefono, '987654321');
  });

  test('retorna error cuando repository falla', () async {
    repo.shouldFail = true;
    final result = await usecase(
      telefono: '987654321',
      password: '123456',
    );
    expect(result, isA<ApiError<Usuario>>());
  });
}

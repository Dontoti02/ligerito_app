// test/features/auth/data/repositories/auth_repository_mock_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

void main() {
  late AuthRepositoryMock repo;

  setUp(() {
    repo = AuthRepositoryMock();
  });

  group('iniciarSesion', () {
    test('retorna error si password < 6 chars', () async {
      final result = await repo.iniciarSesion(
        telefono: '987654321',
        password: '12345',
      );
      expect(result, isA<ApiError<Usuario>>());
    });

    test('retorna éxito con rol cliente para teléfono estándar', () async {
      final result = await repo.iniciarSesion(
        telefono: '987654321',
        password: '123456',
      );
      expect(result, isA<ApiSuccess<Usuario>>());
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.rol, RolUsuario.cliente);
      expect(usuario.telefono, '987654321');
      expect(usuario.nombre, 'Cliente Demo');
    });

    test('retorna rol negocio para teléfono 90*', () async {
      final result = await repo.iniciarSesion(
        telefono: '901234567',
        password: '123456',
      );
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.rol, RolUsuario.negocio);
      expect(usuario.nombre, 'Mi Negocio');
    });

    test('retorna rol negocio para teléfono 91*', () async {
      final result = await repo.iniciarSesion(
        telefono: '912345678',
        password: '123456',
      );
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.rol, RolUsuario.negocio);
    });

    test('retorna rol negocio para teléfono 92*', () async {
      final result = await repo.iniciarSesion(
        telefono: '923456789',
        password: '123456',
      );
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.rol, RolUsuario.negocio);
    });

    test('id contiene mock- prefix', () async {
      final result = await repo.iniciarSesion(
        telefono: '987654321',
        password: '123456',
      );
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.id.startsWith('mock-'), isTrue);
    });
  });

  group('registrar', () {
    test('retorna éxito con datos proporcionados', () async {
      final result = await repo.registrar(
        nombre: 'María',
        telefono: '987654321',
        password: 'abcdef',
        email: 'maria@test.com',
      );
      expect(result, isA<ApiSuccess<Usuario>>());
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.nombre, 'María');
      expect(usuario.telefono, '987654321');
      expect(usuario.email, 'maria@test.com');
      expect(usuario.rol, RolUsuario.cliente);
    });

    test('email es null si no se proporciona', () async {
      final result = await repo.registrar(
        nombre: 'Pedro',
        telefono: '987654321',
        password: '123456',
      );
      final usuario = (result as ApiSuccess<Usuario>).data;
      expect(usuario.email, isNull);
    });
  });

  group('cerrarSesion', () {
    test('no lanza excepciones', () async {
      await repo.cerrarSesion();
    });
  });
}

// test/features/auth/data/models/usuario_dto_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/features/auth/data/models/usuario_dto.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

void main() {
  final json = {
    'id': 'u1',
    'nombre': 'Juan',
    'telefono': '987654321',
    'email': 'juan@test.com',
    'rol': 'cliente',
    'foto_url': 'https://example.com/foto.jpg',
  };

  group('UsuarioDto.fromJson', () {
    test('parsea todos los campos', () {
      final dto = UsuarioDto.fromJson(json);
      expect(dto.id, 'u1');
      expect(dto.nombre, 'Juan');
      expect(dto.telefono, '987654321');
      expect(dto.email, 'juan@test.com');
      expect(dto.rol, RolUsuario.cliente);
      expect(dto.fotoUrl, 'https://example.com/foto.jpg');
    });

    test('campos opcionales null si faltan', () {
      final minimal = {
        'id': 'u2',
        'nombre': 'Ana',
        'telefono': '912345678',
        'rol': 'negocio',
      };
      final dto = UsuarioDto.fromJson(minimal);
      expect(dto.email, isNull);
      expect(dto.fotoUrl, isNull);
    });

    test('rol desconocido defaultea a cliente', () {
      final badRol = {
        'id': 'u3',
        'nombre': 'Test',
        'telefono': '900000000',
        'rol': 'rol_inexistente',
      };
      final dto = UsuarioDto.fromJson(badRol);
      expect(dto.rol, RolUsuario.cliente);
    });
  });

  group('UsuarioDto.toJson', () {
    test('serializa todos los campos', () {
      final dto = UsuarioDto(
        id: 'u1',
        nombre: 'Juan',
        telefono: '987654321',
        email: 'juan@test.com',
        rol: RolUsuario.cliente,
        fotoUrl: 'https://example.com/foto.jpg',
      );
      final map = dto.toJson();
      expect(map['id'], 'u1');
      expect(map['nombre'], 'Juan');
      expect(map['telefono'], '987654321');
      expect(map['email'], 'juan@test.com');
      expect(map['rol'], 'cliente');
      expect(map['foto_url'], 'https://example.com/foto.jpg');
    });
  });

  group('UsuarioDto.toEntity', () {
    test('convierte a entidad correctamente', () {
      final dto = UsuarioDto.fromJson(json);
      final entity = dto.toEntity();
      expect(entity, isA<Usuario>());
      expect(entity.id, 'u1');
      expect(entity.nombre, 'Juan');
      expect(entity.telefono, '987654321');
      expect(entity.email, 'juan@test.com');
      expect(entity.rol, RolUsuario.cliente);
      expect(entity.fotoUrl, 'https://example.com/foto.jpg');
    });
  });

  group('roundtrip', () {
    test('fromJson -> toJson -> fromJson mantiene datos', () {
      final dto1 = UsuarioDto.fromJson(json);
      final map = dto1.toJson();
      final dto2 = UsuarioDto.fromJson(map);
      expect(dto1.id, dto2.id);
      expect(dto1.nombre, dto2.nombre);
      expect(dto1.telefono, dto2.telefono);
      expect(dto1.rol, dto2.rol);
    });
  });
}

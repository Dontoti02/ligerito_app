// lib/features/auth/data/models/usuario_dto.dart
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

class UsuarioDto {
  final String id;
  final String nombre;
  final String telefono;
  final String? email;
  final RolUsuario rol;
  final String? fotoUrl;

  const UsuarioDto({
    required this.id,
    required this.nombre,
    required this.telefono,
    this.email,
    required this.rol,
    this.fotoUrl,
  });

  factory UsuarioDto.fromJson(Map<String, dynamic> json) {
    return UsuarioDto(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      telefono: json['telefono'] as String,
      email: json['email'] as String?,
      rol: RolUsuario.values.firstWhere(
        (r) => r.name == json['rol'],
        orElse: () => RolUsuario.cliente,
      ),
      fotoUrl: json['foto_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'telefono': telefono,
        'email': email,
        'rol': rol.name,
        'foto_url': fotoUrl,
      };

  Usuario toEntity() => Usuario(
        id: id,
        nombre: nombre,
        telefono: telefono,
        email: email,
        rol: rol,
        fotoUrl: fotoUrl,
      );
}

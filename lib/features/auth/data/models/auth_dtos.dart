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
      id: json['id']?.toString() ?? '',
      nombre: json['nombre'] as String? ?? '',
      telefono: json['telefono'] as String? ?? '',
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

class AuthLoginResponseDto {
  final UsuarioDto usuario;
  final String accessToken;
  final String refreshToken;

  const AuthLoginResponseDto({
    required this.usuario,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthLoginResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthLoginResponseDto(
      usuario: UsuarioDto.fromJson(json['usuario'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}

class AuthRegisterResponseDto {
  final UsuarioDto usuario;
  final String accessToken;
  final String refreshToken;

  const AuthRegisterResponseDto({
    required this.usuario,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthRegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthRegisterResponseDto(
      usuario: UsuarioDto.fromJson(json['usuario'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}

class AuthRefreshResponseDto {
  final String accessToken;

  const AuthRefreshResponseDto({required this.accessToken});

  factory AuthRefreshResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthRefreshResponseDto(
      accessToken: json['access_token'] as String,
    );
  }
}

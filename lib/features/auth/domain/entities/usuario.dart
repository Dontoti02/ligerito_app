// lib/features/auth/domain/entities/usuario.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'usuario.freezed.dart';

enum RolUsuario { cliente, negocio, repartidor }

@freezed
class Usuario with _$Usuario {
  const factory Usuario({
    required String id,
    required String nombre,
    required String telefono,
    String? email,
    required RolUsuario rol,
    String? fotoUrl,
  }) = _Usuario;
}

// lib/features/auth/domain/usecases/cerrar_sesion.dart
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class CerrarSesion {
  final AuthRepository _repository;

  const CerrarSesion(this._repository);

  Future<void> call() => _repository.cerrarSesion();
}

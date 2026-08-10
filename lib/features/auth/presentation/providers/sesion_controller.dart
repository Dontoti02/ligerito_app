// lib/features/auth/presentation/providers/sesion_controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/usecases/cerrar_sesion.dart';
import 'package:ligerito/features/auth/domain/usecases/iniciar_sesion.dart';
import 'package:ligerito/features/auth/domain/usecases/registrar_usuario.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sesion_controller.freezed.dart';
part 'sesion_controller.g.dart';

@freezed
sealed class SesionState with _$SesionState {
  const factory SesionState.cargando() = SesionCargando;
  const factory SesionState.autenticado(Usuario usuario) = SesionAutenticada;
  const factory SesionState.noAutenticado() = SesionNoAutenticada;
}

@Riverpod(keepAlive: true)
class SesionController extends _$SesionController {
  @override
  Future<SesionState> build() async => const SesionState.noAutenticado();

  Future<void> iniciarSesion(String telefono, String password) async {
    state = const AsyncData(SesionState.cargando());
    final repo = AuthRepositoryMock();
    final result = await IniciarSesion(repo).call(
      telefono: telefono,
      password: password,
    );
    state = AsyncData(
      switch (result) {
        ApiSuccess(:final data) => SesionState.autenticado(data),
        ApiError() => const SesionState.noAutenticado(),
      },
    );
  }

  Future<void> registrar(String nombre, String telefono, String password,
      {String? email}) async {
    state = const AsyncData(SesionState.cargando());
    final repo = AuthRepositoryMock();
    final result = await RegistrarUsuario(repo).call(
      nombre: nombre,
      telefono: telefono,
      password: password,
      email: email,
    );
    state = AsyncData(
      switch (result) {
        ApiSuccess(:final data) => SesionState.autenticado(data),
        ApiError() => const SesionState.noAutenticado(),
      },
    );
  }

  Future<void> cerrarSesion() async {
    final repo = AuthRepositoryMock();
    await CerrarSesion(repo).call();
    state = const AsyncData(SesionState.noAutenticado());
  }
}

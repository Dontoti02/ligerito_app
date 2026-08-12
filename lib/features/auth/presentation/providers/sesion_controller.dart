import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/core/network/providers/dio_providers.dart';
import 'package:ligerito/features/auth/data/repositories/auth_repository_remote.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sesion_controller.freezed.dart';
part 'sesion_controller.g.dart';

@freezed
sealed class SesionState with _$SesionState {
  const factory SesionState.cargando() = SesionCargando;
  const factory SesionState.autenticado(Usuario usuario) = SesionAutenticada;
  const factory SesionState.noAutenticado({String? error}) = SesionNoAutenticada;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  final storage = ref.watch(secureStorageServiceProvider);
  return AuthRepositoryRemote(dio, storage);
}

@Riverpod(keepAlive: true)
class SesionController extends _$SesionController {
  @override
  Future<SesionState> build() async {
    final storage = ref.watch(secureStorageServiceProvider);
    final token = await storage.leerToken();
    if (token == null) return const SesionState.noAutenticado();
    // Token exists but we don't have user info cached
    // In a real app, we'd call a /me endpoint here
    return const SesionState.noAutenticado();
  }

  Future<void> iniciarSesion(String telefono, String password) async {
    state = const AsyncData(SesionState.cargando());
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.iniciarSesion(
      telefono: telefono,
      password: password,
    );
    state = AsyncData(
      switch (result) {
        ApiSuccess(:final data) => SesionState.autenticado(data),
        ApiError(:final failure) => SesionState.noAutenticado(error: failure.message),
      },
    );
  }

  Future<void> registrar(String nombre, String telefono, String password,
      {String? email}) async {
    state = const AsyncData(SesionState.cargando());
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.registrar(
      nombre: nombre,
      telefono: telefono,
      password: password,
      email: email,
    );
    state = AsyncData(
      switch (result) {
        ApiSuccess(:final data) => SesionState.autenticado(data),
        ApiError(:final failure) => SesionState.noAutenticado(error: failure.message),
      },
    );
  }

  Future<void> cerrarSesion() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.cerrarSesion();
    state = const AsyncData(SesionState.noAutenticado());
  }
}

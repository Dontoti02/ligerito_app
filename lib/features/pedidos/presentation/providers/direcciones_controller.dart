import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/core/network/providers/dio_providers.dart';
import 'package:ligerito/features/pedidos/data/repositories/direcciones_repository_remote.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/repositories/direcciones_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'direcciones_controller.freezed.dart';
part 'direcciones_controller.g.dart';

@freezed
sealed class DireccionesState with _$DireccionesState {
  const factory DireccionesState.cargando() = _Cargando;
  const factory DireccionesState.loaded(List<Direccion> direcciones) = _Loaded;
  const factory DireccionesState.error(String mensaje) = _Error;
}

@Riverpod(keepAlive: true)
DireccionesRepository direccionesRepository(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return DireccionesRepositoryRemote(dio);
}

@Riverpod(keepAlive: true)
class DireccionesController extends _$DireccionesController {
  @override
  Future<DireccionesState> build() async {
    final repo = ref.watch(direccionesRepositoryProvider);
    try {
      final direcciones = await repo.getDirecciones();
      return DireccionesState.loaded(direcciones);
    } catch (e) {
      return DireccionesState.error('Error al cargar direcciones');
    }
  }

  Future<void> crear(Direccion direccion) async {
    try {
      final repo = ref.read(direccionesRepositoryProvider);
      await repo.crear(direccion);
      final direcciones = await repo.getDirecciones();
      state = AsyncData(DireccionesState.loaded(direcciones));
    } catch (e) {
      state = AsyncData(DireccionesState.error('Error al crear dirección'));
    }
  }

  Future<void> actualizar(Direccion direccion) async {
    try {
      final repo = ref.read(direccionesRepositoryProvider);
      await repo.actualizar(direccion);
      final direcciones = await repo.getDirecciones();
      state = AsyncData(DireccionesState.loaded(direcciones));
    } catch (e) {
      state = AsyncData(DireccionesState.error('Error al actualizar dirección'));
    }
  }

  Future<void> eliminar(String id) async {
    try {
      final repo = ref.read(direccionesRepositoryProvider);
      await repo.eliminar(id);
      final direcciones = await repo.getDirecciones();
      state = AsyncData(DireccionesState.loaded(direcciones));
    } catch (e) {
      state = AsyncData(DireccionesState.error('Error al eliminar dirección'));
    }
  }
}

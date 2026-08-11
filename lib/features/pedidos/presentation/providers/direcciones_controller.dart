import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/pedidos/data/repositories/direcciones_repository_mock.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
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
class DireccionesController extends _$DireccionesController {
  @override
  Future<DireccionesState> build() async {
    final repo = DireccionesRepositoryMock();
    final direcciones = await repo.getDirecciones();
    return DireccionesState.loaded(direcciones);
  }

  Future<void> crear(Direccion direccion) async {
    state = const AsyncData(DireccionesState.cargando());
    final repo = DireccionesRepositoryMock();
    await repo.crear(direccion);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }

  Future<void> actualizar(Direccion direccion) async {
    state = const AsyncData(DireccionesState.cargando());
    final repo = DireccionesRepositoryMock();
    await repo.actualizar(direccion);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }

  Future<void> eliminar(String id) async {
    state = const AsyncData(DireccionesState.cargando());
    final repo = DireccionesRepositoryMock();
    await repo.eliminar(id);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }
}

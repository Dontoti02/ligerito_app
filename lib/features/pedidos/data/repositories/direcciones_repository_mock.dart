import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/repositories/direcciones_repository.dart';

class DireccionesRepositoryMock implements DireccionesRepository {
  static final DireccionesRepositoryMock _instance =
      DireccionesRepositoryMock._internal();

  factory DireccionesRepositoryMock() => _instance;

  DireccionesRepositoryMock._internal() {
    _direcciones = [
      const Direccion(
        id: 'dir-casa',
        etiqueta: 'Casa',
        direccionTexto: 'Jr. Lambayeque 123, Piura',
        lat: -5.1898,
        lng: -80.6328,
        referencia: 'Frente al parque',
      ),
      const Direccion(
        id: 'dir-trabajo',
        etiqueta: 'Trabajo',
        direccionTexto: 'Av. Grau 456, Piura',
        lat: -5.1920,
        lng: -80.6550,
        referencia: 'Edificio azul, 3er piso',
      ),
    ];
  }

  late List<Direccion> _direcciones;

  @override
  Future<List<Direccion>> getDirecciones() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_direcciones);
  }

  @override
  Future<Direccion> crear(Direccion direccion) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _direcciones = [..._direcciones, direccion];
    return direccion;
  }

  @override
  Future<Direccion> actualizar(Direccion direccion) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _direcciones = [
      for (final d in _direcciones)
        if (d.id == direccion.id) direccion else d,
    ];
    return direccion;
  }

  @override
  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _direcciones = _direcciones.where((d) => d.id != id).toList();
  }
}

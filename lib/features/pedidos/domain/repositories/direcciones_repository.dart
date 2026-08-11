import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

abstract class DireccionesRepository {
  Future<List<Direccion>> getDirecciones();
  Future<Direccion> crear(Direccion direccion);
  Future<Direccion> actualizar(Direccion direccion);
  Future<void> eliminar(String id);
}

import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/repositories/pedidos_repository.dart';

class PedidosRepositoryMock implements PedidosRepository {
  static final PedidosRepositoryMock _instance = PedidosRepositoryMock._internal();

  factory PedidosRepositoryMock() => _instance;

  PedidosRepositoryMock._internal() {
    final now = DateTime.now();
    _pedidos = [
      Pedido(
        id: 'ped001',
        negocioId: 'n1',
        items: const [
          ItemCarrito(
            producto: Producto(
              id: 'p1-1',
              negocioId: 'n1',
              nombre: 'Pollo a la brasa (1/4)',
              descripcion: 'Cuarto de pollo a la brasa con papas fritas y ensalada',
              precioEnCentavos: 1890,
              disponible: true,
              seccionMenu: 'Pollos',
            ),
            cantidad: 2,
          ),
          ItemCarrito(
            producto: Producto(
              id: 'p1-4',
              negocioId: 'n1',
              nombre: 'Inca Kola 1.5L',
              precioEnCentavos: 750,
              disponible: true,
              seccionMenu: 'Bebidas',
            ),
            cantidad: 1,
          ),
        ],
        estado: EstadoPedido.entregado,
        metodoPago: MetodoPago.yape,
        subtotalEnCentavos: 4530,
        costoEnvioEnCentavos: 350,
        totalEnCentavos: 4880,
        direccionEntrega: const Direccion(
          id: 'dir-casa',
          etiqueta: 'Casa',
          direccionTexto: 'Jr. Lambayeque 123, Piura',
          lat: -5.1898,
          lng: -80.6328,
          referencia: 'Frente al parque',
        ),
        clienteNombre: 'Cliente Demo',
        clienteTelefono: '967123456',
        creadoEn: now.subtract(const Duration(hours: 2)),
      ),
      Pedido(
        id: 'ped002',
        negocioId: 'n2',
        items: const [
          ItemCarrito(
            producto: Producto(
              id: 'p2-1',
              negocioId: 'n2',
              nombre: 'Paracetamol 500mg x 20',
              descripcion: 'Caja de 20 tabletas de paracetamol 500mg',
              precioEnCentavos: 850,
              disponible: true,
              seccionMenu: 'Analgésicos',
            ),
            cantidad: 1,
          ),
          ItemCarrito(
            producto: Producto(
              id: 'p2-3',
              negocioId: 'n2',
              nombre: 'Vitamina C 1000mg x 30',
              descripcion: 'Frasco con 30 tabletas efervescentes',
              precioEnCentavos: 2500,
              disponible: true,
              seccionMenu: 'Vitaminas',
            ),
            cantidad: 1,
          ),
        ],
        estado: EstadoPedido.entregado,
        metodoPago: MetodoPago.efectivo,
        subtotalEnCentavos: 3350,
        costoEnvioEnCentavos: 250,
        totalEnCentavos: 3600,
        direccionEntrega: const Direccion(
          id: 'dir-trabajo',
          etiqueta: 'Trabajo',
          direccionTexto: 'Av. Grau 456, Piura',
          lat: -5.1920,
          lng: -80.6550,
          referencia: 'Edificio azul, 3er piso',
        ),
        clienteNombre: 'Cliente Demo',
        clienteTelefono: '967123456',
        creadoEn: now.subtract(const Duration(days: 1)),
      ),
      Pedido(
        id: 'ped003',
        negocioId: 'n1',
        items: const [
          ItemCarrito(
            producto: Producto(
              id: 'p1-2',
              negocioId: 'n1',
              nombre: 'Pollo a la brasa (1/2)',
              descripcion: 'Medio pollo a la brasa con papas fritas y ensalada',
              precioEnCentavos: 3290,
              disponible: true,
              seccionMenu: 'Pollos',
            ),
            cantidad: 1,
          ),
        ],
        estado: EstadoPedido.enCamino,
        metodoPago: MetodoPago.yape,
        subtotalEnCentavos: 3290,
        costoEnvioEnCentavos: 300,
        totalEnCentavos: 3590,
        direccionEntrega: const Direccion(
          id: 'dir-casa',
          etiqueta: 'Casa',
          direccionTexto: 'Jr. Lambayeque 123, Piura',
          lat: -5.1898,
          lng: -80.6328,
          referencia: 'Frente al parque',
        ),
        clienteNombre: 'Cliente Demo',
        clienteTelefono: '967123456',
        creadoEn: now.subtract(const Duration(minutes: 20)),
      ),
    ];
  }

  late List<Pedido> _pedidos;

  @override
  Future<List<Pedido>> getMisPedidos() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_pedidos);
  }

  @override
  Future<Pedido?> getPedido(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _pedidos.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Pedido> crearPedido(Pedido pedido) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _pedidos = [pedido, ..._pedidos];
    return pedido;
  }

  @override
  Future<void> actualizarEstado(String id, EstadoPedido estado) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _pedidos = [
      for (final p in _pedidos)
        if (p.id == id)
          Pedido(
            id: p.id,
            negocioId: p.negocioId,
            items: p.items,
            estado: estado,
            metodoPago: p.metodoPago,
            subtotalEnCentavos: p.subtotalEnCentavos,
            costoEnvioEnCentavos: p.costoEnvioEnCentavos,
            totalEnCentavos: p.totalEnCentavos,
            direccionEntrega: p.direccionEntrega,
            creadoEn: p.creadoEn,
            clienteNombre: p.clienteNombre,
            clienteTelefono: p.clienteTelefono,
          )
        else
          p,
    ];
  }
}

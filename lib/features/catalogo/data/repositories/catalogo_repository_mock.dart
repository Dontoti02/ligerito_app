// lib/features/catalogo/data/repositories/catalogo_repository_mock.dart
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

class CatalogoRepositoryMock implements CatalogoRepository {
  final List<Negocio> _negocios = [
    Negocio(
      id: 'n1',
      nombre: 'Pollería El Picanterón',
      categoria: 'restaurante',
      logoUrl: 'assets/images/logos/polleria_picanteron.png',
      calificacion: 4.5,
      abierto: true,
      tiempoEstimadoMin: 25,
      costoEnvioBase: 3.00,
      pedidoMinimo: 15.00,
      direccion: const Direccion(
        id: 'dir-n1',
        etiqueta: 'Pollería El Picanterón',
        direccionTexto: 'Av. San Martín 456, Piura',
        lat: -5.1788,
        lng: -80.6544,
      ),
    ),
    Negocio(
      id: 'n2',
      nombre: 'Farmacia San Pablo',
      categoria: 'farmacia',
      logoUrl: 'assets/images/logos/farmacia_san_pablo.png',
      calificacion: 4.8,
      abierto: true,
      tiempoEstimadoMin: 30,
      costoEnvioBase: 2.50,
      pedidoMinimo: 10.00,
      direccion: const Direccion(
        id: 'dir-n2',
        etiqueta: 'Farmacia San Pablo',
        direccionTexto: 'Calle Tacna 234, Piura',
        lat: -5.1850,
        lng: -80.6450,
      ),
    ),
    Negocio(
      id: 'n3',
      nombre: 'Mercado Central Piura',
      categoria: 'mercado',
      logoUrl: 'assets/images/logos/mercado_central.png',
      calificacion: 4.3,
      abierto: true,
      tiempoEstimadoMin: 35,
      costoEnvioBase: 4.00,
      pedidoMinimo: 20.00,
      direccion: const Direccion(
        id: 'dir-n3',
        etiqueta: 'Mercado Central Piura',
        direccionTexto: 'Jr. Lima 123, Piura',
        lat: -5.1820,
        lng: -80.6510,
      ),
    ),
    Negocio(
      id: 'n4',
      nombre: 'Ferretería Don José',
      categoria: 'ferreteria',
      logoUrl: 'assets/images/logos/ferreteria_don_jose.png',
      calificacion: 4.2,
      abierto: false,
      tiempoEstimadoMin: 40,
      costoEnvioBase: 5.00,
      pedidoMinimo: 20.00,
      direccion: const Direccion(
        id: 'dir-n4',
        etiqueta: 'Ferretería Don José',
        direccionTexto: 'Av. Sullana 789, Piura',
        lat: -5.1900,
        lng: -80.6480,
      ),
    ),
    Negocio(
      id: 'n5',
      nombre: 'Cevichería La Boca',
      categoria: 'restaurante',
      logoUrl: 'assets/images/logos/cevicheria_la_boca.png',
      calificacion: 4.6,
      abierto: true,
      tiempoEstimadoMin: 30,
      costoEnvioBase: 3.50,
      pedidoMinimo: 18.00,
      direccion: const Direccion(
        id: 'dir-n5',
        etiqueta: 'Cevichería La Boca',
        direccionTexto: 'Calle Huancavelica 567, Piura',
        lat: -5.1750,
        lng: -80.6580,
      ),
    ),
    Negocio(
      id: 'n6',
      nombre: 'Botica Salud Total',
      categoria: 'farmacia',
      logoUrl: 'assets/images/logos/botica_salud_total.png',
      calificacion: 4.4,
      abierto: false,
      tiempoEstimadoMin: 25,
      costoEnvioBase: 2.00,
      pedidoMinimo: 8.00,
      direccion: const Direccion(
        id: 'dir-n6',
        etiqueta: 'Botica Salud Total',
        direccionTexto: 'Av. Nasca 345, Piura',
        lat: -5.1880,
        lng: -80.6420,
      ),
    ),
    Negocio(
      id: 'n7',
      nombre: 'Panadería La Espiga',
      categoria: 'mercado',
      logoUrl: 'assets/images/logos/panaderia_la_espiga.png',
      calificacion: 4.7,
      abierto: true,
      tiempoEstimadoMin: 20,
      costoEnvioBase: 2.50,
      pedidoMinimo: 10.00,
      direccion: const Direccion(
        id: 'dir-n7',
        etiqueta: 'Panadería La Espiga',
        direccionTexto: 'Jr. Ayacucho 890, Piura',
        lat: -5.1810,
        lng: -80.6490,
      ),
    ),
    Negocio(
      id: 'n8',
      nombre: 'Electrohogar',
      categoria: 'ferreteria',
      logoUrl: 'assets/images/logos/electrohogar.png',
      calificacion: 4.0,
      abierto: false,
      tiempoEstimadoMin: 45,
      costoEnvioBase: 6.00,
      pedidoMinimo: 30.00,
      direccion: const Direccion(
        id: 'dir-n8',
        etiqueta: 'Electrohogar',
        direccionTexto: 'Av. Grau 1234, Piura',
        lat: -5.1920,
        lng: -80.6550,
      ),
    ),
  ];

  final Map<String, List<Producto>> _productos = {
    'n1': [
      const Producto(
        id: 'p1-1',
        negocioId: 'n1',
        nombre: 'Pollo a la brasa (1/4)',
        descripcion: 'Cuarto de pollo a la brasa con papas fritas y ensalada',
        precioEnCentavos: 1890,
        disponible: true,
        seccionMenu: 'Pollos',
      ),
      const Producto(
        id: 'p1-2',
        negocioId: 'n1',
        nombre: 'Pollo a la brasa (1/2)',
        descripcion: 'Medio pollo a la brasa con papas fritas y ensalada',
        precioEnCentavos: 3290,
        disponible: true,
        seccionMenu: 'Pollos',
      ),
      const Producto(
        id: 'p1-3',
        negocioId: 'n1',
        nombre: 'Pollo a la brasa (entero)',
        descripcion: 'Pollo entero a la brasa con papas fritas y ensalada',
        precioEnCentavos: 5990,
        disponible: true,
        seccionMenu: 'Pollos',
      ),
      const Producto(
        id: 'p1-4',
        negocioId: 'n1',
        nombre: 'Inca Kola 1.5L',
        precioEnCentavos: 750,
        disponible: true,
        seccionMenu: 'Bebidas',
      ),
      const Producto(
        id: 'p1-5',
        negocioId: 'n1',
        nombre: 'Chicha morada 1L',
        precioEnCentavos: 600,
        disponible: true,
        seccionMenu: 'Bebidas',
      ),
    ],
    'n2': [
      const Producto(
        id: 'p2-1',
        negocioId: 'n2',
        nombre: 'Paracetamol 500mg x 20',
        descripcion: 'Caja de 20 tabletas de paracetamol 500mg',
        precioEnCentavos: 850,
        disponible: true,
        seccionMenu: 'Analgésicos',
      ),
      const Producto(
        id: 'p2-2',
        negocioId: 'n2',
        nombre: 'Ibuprofeno 400mg x 10',
        descripcion: 'Caja de 10 cápsulas de ibuprofeno 400mg',
        precioEnCentavos: 1200,
        disponible: true,
        seccionMenu: 'Antiinflamatorios',
      ),
      const Producto(
        id: 'p2-3',
        negocioId: 'n2',
        nombre: 'Vitamina C 1000mg x 30',
        descripcion: 'Frasco con 30 tabletas efervescentes',
        precioEnCentavos: 2500,
        disponible: true,
        seccionMenu: 'Vitaminas',
      ),
      const Producto(
        id: 'p2-4',
        negocioId: 'n2',
        nombre: 'Alcohol medicinal 250ml',
        precioEnCentavos: 950,
        disponible: true,
        seccionMenu: 'Antisépticos',
      ),
    ],
    'n3': [
      const Producto(
        id: 'p3-1',
        negocioId: 'n3',
        nombre: 'Tomate italiano x kg',
        precioEnCentavos: 350,
        disponible: true,
        seccionMenu: 'Verduras',
      ),
      const Producto(
        id: 'p3-2',
        negocioId: 'n3',
        nombre: 'Cebolla roja x kg',
        precioEnCentavos: 280,
        disponible: true,
        seccionMenu: 'Verduras',
      ),
      const Producto(
        id: 'p3-3',
        negocioId: 'n3',
        nombre: 'Papa blanca x kg',
        precioEnCentavos: 250,
        disponible: true,
        seccionMenu: 'Tubérculos',
      ),
      const Producto(
        id: 'p3-4',
        negocioId: 'n3',
        nombre: 'Limón sutil x kg',
        precioEnCentavos: 450,
        disponible: true,
        seccionMenu: 'Frutas',
      ),
      const Producto(
        id: 'p3-5',
        negocioId: 'n3',
        nombre: 'Arroz costeño 5kg',
        precioEnCentavos: 2290,
        disponible: true,
        seccionMenu: 'Abarrotes',
      ),
    ],
    'n5': [
      const Producto(
        id: 'p5-1',
        negocioId: 'n5',
        nombre: 'Ceviche de pescado',
        descripcion: 'Pescado fresco marinado en limón con cebolla y ají',
        precioEnCentavos: 2500,
        disponible: true,
        seccionMenu: 'Ceviches',
      ),
      const Producto(
        id: 'p5-2',
        negocioId: 'n5',
        nombre: 'Ceviche mixto',
        descripcion: 'Pescado y mariscos marinados en limón',
        precioEnCentavos: 3200,
        disponible: true,
        seccionMenu: 'Ceviches',
      ),
      const Producto(
        id: 'p5-3',
        negocioId: 'n5',
        nombre: 'Leche de tigre',
        descripcion: 'Vaso de leche de tigre con pescado y mariscos',
        precioEnCentavos: 1800,
        disponible: true,
        seccionMenu: 'Bebidas',
      ),
      const Producto(
        id: 'p5-4',
        negocioId: 'n5',
        nombre: 'Chicharrón de pescado',
        descripcion: 'Pescado frito crocante con yuca y salsa criolla',
        precioEnCentavos: 2800,
        disponible: false,
        seccionMenu: 'Platos de fondo',
      ),
    ],
    'n7': [
      const Producto(
        id: 'p7-1',
        negocioId: 'n7',
        nombre: 'Pan francés x 10',
        precioEnCentavos: 500,
        disponible: true,
        seccionMenu: 'Panes',
      ),
      const Producto(
        id: 'p7-2',
        negocioId: 'n7',
        nombre: 'PanIntegral x 6',
        descripcion: 'Pan integral con semillas',
        precioEnCentavos: 900,
        disponible: true,
        seccionMenu: 'Panes',
      ),
      const Producto(
        id: 'p7-3',
        negocioId: 'n7',
        nombre: 'Empanada de pollo',
        precioEnCentavos: 350,
        disponible: true,
        seccionMenu: 'Empanadas',
      ),
      const Producto(
        id: 'p7-4',
        negocioId: 'n7',
        nombre: 'Empanada de queso',
        precioEnCentavos: 300,
        disponible: true,
        seccionMenu: 'Empanadas',
      ),
      const Producto(
        id: 'p7-5',
        negocioId: 'n7',
        nombre: 'Torta de chocolate',
        descripcion: 'Porción de torta húmeda de chocolate',
        precioEnCentavos: 800,
        disponible: true,
        seccionMenu: 'Postres',
      ),
    ],
  };

  @override
  Future<List<Negocio>> getNegocios() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable(_negocios);
  }

  @override
  Future<Negocio?> getNegocio(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    try {
      return _negocios.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Producto>> getProductosByNegocio(String negocioId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.unmodifiable(_productos[negocioId] ?? []);
  }
}

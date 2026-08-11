# Flujo Cliente UI - Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Construir las 8 screens del flujo cliente de Ligerito (Home, Negocio, Carrito, Checkout, Seguimiento, Historial, Perfil, Direcciones) con mock data, widgets compartidos y providers Riverpod.

**Architecture:** Enfoque hybrid — primero mock repos + providers, luego widgets compartidos, luego screens en orden de flujo. Cada feature sigue la estructura existente: domain (interfaces + entidades), data (mock repos), presentation (controllers Riverpod + screens + widgets).

**Tech Stack:** Flutter, Riverpod (riverpod_annotation + code gen), freezed, go_router, Material 3, intl

## Global Constraints

- SDK: Dart ^3.12.2
- Todos los precios en centavos (int) en entidades, formatear con `CurrencyFormatter.formatoPen()`
- Fechas relativas con `DateFormatter.tiempoTranscurrido()`
- Sin emojis — solo Material Icons
- L10n: todas las strings ya existen en `app_es.arb`, usar `context.l10n.*`
- Code gen obligatorio: después de crear/modify controllers con `@riverpod`, correr `dart run build_runner build`
- Seguir patrón de `AuthRepositoryMock`: `implements` de interface abstract, delay simulado, datos hardcodeados
- Widgets reutilizar: `LigeritoButton`, `LigeritoTextField`, `ErrorView`, `EmptyStateView`, `LigeritoListSkeleton`
- Theme: `LigeritoColors`, `LigeritoTextStyles` (no hardcodear colores/fuentes)

---

### Task 1: Catalogo - Repos, Mock Data y Providers

**Files:**
- Create: `lib/features/catalogo/domain/repositories/catalogo_repository.dart`
- Create: `lib/features/catalogo/data/repositories/catalogo_repository_mock.dart`
- Create: `lib/features/catalogo/presentation/providers/catalogo_providers.dart`

**Interfaces:**
- Produces: `CatalogoRepository` abstract class con `getNegocios()`, `getNegocio(id)`, `getProductosByNegocio(negocioId)`
- Produces: `catalogoRepositoryProvider` y `negociosProvider` para consumo en screens

- [ ] **Step 1: Crear la interfaz CatalogoRepository**

```dart
// lib/features/catalogo/domain/repositories/catalogo_repository.dart
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

abstract class CatalogoRepository {
  Future<List<Negocio>> getNegocios();
  Future<Negocio?> getNegocio(String id);
  Future<List<Producto>> getProductosByNegocio(String negocioId);
}
```

- [ ] **Step 2: Crear el mock con datos realistas**

```dart
// lib/features/catalogo/data/repositories/catalogo_repository_mock.dart
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

class CatalogoRepositoryMock implements CatalogoRepository {
  static final _negocios = [
    Negocio(
      id: 'n1',
      nombre: 'Pollería El Picanterón',
      categoria: 'restaurante',
      logoUrl: '',
      calificacion: 4.5,
      abierto: true,
      tiempoEstimadoMin: 25,
      costoEnvioBase: 3.0,
      pedidoMinimo: 15.0,
      direccion: const Direccion(id: 'd1', etiqueta: '', direccionTexto: 'Calle Lima 123', lat: -5.1783, lng: -80.6549),
    ),
    Negocio(
      id: 'n2',
      nombre: 'Farmacia San Pablo',
      categoria: 'farmacia',
      logoUrl: '',
      calificacion: 4.8,
      abierto: true,
      tiempoEstimadoMin: 30,
      costoEnvioBase: 2.5,
      pedidoMinimo: 10.0,
      direccion: const Direccion(id: 'd2', etiqueta: '', direccionTexto: 'Av. Grau 456', lat: -5.1850, lng: -80.6480),
    ),
    Negocio(
      id: 'n3',
      nombre: 'Mercado Central Piura',
      categoria: 'mercado',
      logoUrl: '',
      calificacion: 4.3,
      abierto: true,
      tiempoEstimadoMin: 35,
      costoEnvioBase: 4.0,
      pedidoMinimo: 20.0,
      direccion: const Direccion(id: 'd3', etiqueta: '', direccionTexto: 'Jr. Tacna 200', lat: -5.1900, lng: -80.6600),
    ),
    Negocio(
      id: 'n4',
      nombre: 'Ferretería Don José',
      categoria: 'ferreteria',
      logoUrl: '',
      calificacion: 4.2,
      abierto: false,
      tiempoEstimadoMin: 40,
      costoEnvioBase: 5.0,
      pedidoMinimo: 20.0,
      direccion: const Direccion(id: 'd4', etiqueta: '', direccionTexto: 'Calle Junín 789', lat: -5.1750, lng: -80.6500),
    ),
    Negocio(
      id: 'n5',
      nombre: 'Cevichería La Boca',
      categoria: 'restaurante',
      logoUrl: '',
      calificacion: 4.6,
      abierto: true,
      tiempoEstimadoMin: 30,
      costoEnvioBase: 3.5,
      pedidoMinimo: 18.0,
      direccion: const Direccion(id: 'd5', etiqueta: '', direccionTexto: 'Calle Arequipa 321', lat: -5.1820, lng: -80.6520),
    ),
    Negocio(
      id: 'n6',
      nombre: 'Botica Salud Total',
      categoria: 'farmacia',
      logoUrl: '',
      calificacion: 4.4,
      abierto: false,
      tiempoEstimadoMin: 25,
      costoEnvioBase: 2.0,
      pedidoMinimo: 8.0,
      direccion: const Direccion(id: 'd6', etiqueta: '', direccionTexto: 'Av. España 555', lat: -5.1870, lng: -80.6450),
    ),
    Negocio(
      id: 'n7',
      nombre: 'Panadería La Espiga',
      categoria: 'mercado',
      logoUrl: '',
      calificacion: 4.7,
      abierto: true,
      tiempoEstimadoMin: 20,
      costoEnvioBase: 2.5,
      pedidoMinimo: 10.0,
      direccion: const Direccion(id: 'd7', etiqueta: '', direccionTexto: 'Calle Lambayeque 88', lat: -5.1790, lng: -80.6530),
    ),
    Negocio(
      id: 'n8',
      nombre: 'Electrohogar',
      categoria: 'ferreteria',
      logoUrl: '',
      calificacion: 4.0,
      abierto: false,
      tiempoEstimadoMin: 45,
      costoEnvioBase: 6.0,
      pedidoMinimo: 30.0,
      direccion: const Direccion(id: 'd8', etiqueta: '', direccionTexto: 'Av. Sullana 1200', lat: -5.1700, lng: -80.6580),
    ),
  ];

  static final _productos = {
    'n1': [
      const Producto(id: 'p1', negocioId: 'n1', nombre: '1/4 Pollo + papas + gaseosa', descripcion: 'Cuarto de pollo a la brasa con papas fritas y gaseosa de 500ml', precioEnCentavos: 1890, disponible: true, seccionMenu: 'Pollos a la brasa'),
      const Producto(id: 'p2', negocioId: 'n1', nombre: '1/2 Pollo + papas + gaseosa', descripcion: 'Medio pollo a la brasa con papas fritas y gaseosa de 1.5L', precioEnCentavos: 3290, disponible: true, seccionMenu: 'Pollos a la brasa'),
      const Producto(id: 'p3', negocioId: 'n1', nombre: 'Pollo entero familiar', descripcion: 'Pollo entero con papas familiares y 2 gaseosas de 1.5L', precioEnCentavos: 5990, disponible: true, seccionMenu: 'Pollos a la brasa'),
      const Producto(id: 'p4', negocioId: 'n1', nombre: 'Arroz chaufa', precioEnCentavos: 1200, disponible: true, seccionMenu: 'Complementos'),
      const Producto(id: 'p5', negocioId: 'n1', nombre: 'Inca Kola 1.5L', precioEnCentavos: 800, disponible: true, seccionMenu: 'Bebidas'),
      const Producto(id: 'p6', negocioId: 'n1', nombre: 'Suspiro limeño', precioEnCentavos: 600, disponible: true, seccionMenu: 'Postres'),
    ],
    'n2': [
      const Producto(id: 'p7', negocioId: 'n2', nombre: 'Paracetamol 500mg x10', precioEnCentavos: 350, disponible: true, seccionMenu: 'Analgésicos'),
      const Producto(id: 'p8', negocioId: 'n2', nombre: 'Vitamina C 1000mg x30', precioEnCentavos: 1890, disponible: true, seccionMenu: 'Vitaminas'),
      const Producto(id: 'p9', negocioId: 'n2', nombre: 'Alcohol medicinal 500ml', precioEnCentavos: 750, disponible: true, seccionMenu: 'Antisépticos'),
      const Producto(id: 'p10', negocioId: 'n2', nombre: 'Curitas x20', precioEnCentavos: 450, disponible: false, seccionMenu: 'Primeros auxilios'),
    ],
    'n3': [
      const Producto(id: 'p11', negocioId: 'n3', nombre: '1kg tomates', precioEnCentavos: 300, disponible: true, seccionMenu: 'Verduras'),
      const Producto(id: 'p12', negocioId: 'n3', nombre: '1kg papas', precioEnCentavos: 250, disponible: true, seccionMenu: 'Verduras'),
      const Producto(id: 'p13', negocioId: 'n3', nombre: '1kg arroz', precioEnCentavos: 450, disponible: true, seccionMenu: 'Abarrotes'),
      const Producto(id: 'p14', negocioId: 'n3', nombre: '6 huevos', precioEnCentavos: 380, disponible: true, seccionMenu: 'Abarrotes'),
    ],
    'n5': [
      const Producto(id: 'p15', negocioId: 'n5', nombre: 'Ceviche clásico', descripcion: 'Pescado fresco con limón, cebolla, ají y camote', precioEnCentavos: 2500, disponible: true, seccionMenu: 'Ceviches'),
      const Producto(id: 'p16', negocioId: 'n5', nombre: 'Ceviche mixto', descripcion: 'Pescado y mariscos con limón, cebolla y ají', precioEnCentavos: 3200, disponible: true, seccionMenu: 'Ceviches'),
      const Producto(id: 'p17', negocioId: 'n5', nombre: 'Leche de tigre', precioEnCentavos: 1200, disponible: true, seccionMenu: 'Bebidas'),
      const Producto(id: 'p18', negocioId: 'n5', nombre: 'Chicha morada 1L', precioEnCentavos: 800, disponible: true, seccionMenu: 'Bebidas'),
    ],
    'n7': [
      const Producto(id: 'p19', negocioId: 'n7', nombre: 'Pan francés x10', precioEnCentavos: 300, disponible: true, seccionMenu: 'Panes'),
      const Producto(id: 'p20', negocioId: 'n7', nombre: 'Torta de chocolate', precioEnCentavos: 3500, disponible: true, seccionMenu: 'Tortas'),
      const Producto(id: 'p21', negocioId: 'n7', nombre: 'Empanadas de pollo x3', precioEnCentavos: 900, disponible: true, seccionMenu: 'Salados'),
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
    return _productos[negocioId] ?? [];
  }
}
```

- [ ] **Step 3: Crear los providers**

```dart
// lib/features/catalogo/presentation/providers/catalogo_providers.dart
import 'package:ligerito/features/catalogo/data/repositories/catalogo_repository_mock.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/domain/repositories/catalogo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'catalogo_providers.g.dart';

@Riverpod(keepAlive: true)
CatalogoRepository catalogoRepository(Ref ref) => CatalogoRepositoryMock();

@riverpod
Future<List<Negocio>> negocios(Ref ref) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getNegocios();
}

@riverpod
Future<Negocio?> negocio(Ref ref, String id) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getNegocio(id);
}

@riverpod
Future<List<Producto>> productosNegocio(Ref ref, String negocioId) {
  final repo = ref.watch(catalogoRepositoryProvider);
  return repo.getProductosByNegocio(negocioId);
}
```

- [ ] **Step 4: Correr code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 5: Commit**

```bash
git add lib/features/catalogo/
git commit -m "feat(catalogo): add mock repository with providers for businesses and products"
```

---

### Task 2: Direcciones y Pedidos - Repos, Mock Data y Providers

**Files:**
- Create: `lib/features/pedidos/domain/repositories/direcciones_repository.dart`
- Create: `lib/features/pedidos/data/repositories/direcciones_repository_mock.dart`
- Create: `lib/features/pedidos/domain/repositories/pedidos_repository.dart`
- Create: `lib/features/pedidos/data/repositories/pedidos_repository_mock.dart`
- Create: `lib/features/pedidos/presentation/providers/pedidos_providers.dart`
- Create: `lib/features/pedidos/presentation/providers/direcciones_controller.dart`

**Interfaces:**
- Produces: `DireccionesRepository`, `PedidosRepository`
- Produces: `direccionesControllerProvider` (Notifier con CRUD)
- Produces: `pedidosProvider`, `pedidoDetalleProvider`

- [ ] **Step 1: Crear interfaces de repositorios**

```dart
// lib/features/pedidos/domain/repositories/direcciones_repository.dart
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

abstract class DireccionesRepository {
  Future<List<Direccion>> getDirecciones();
  Future<Direccion> crear(Direccion direccion);
  Future<Direccion> actualizar(Direccion direccion);
  Future<void> eliminar(String id);
}
```

```dart
// lib/features/pedidos/domain/repositories/pedidos_repository.dart
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';

abstract class PedidosRepository {
  Future<List<Pedido>> getMisPedidos();
  Future<Pedido?> getPedido(String id);
  Future<Pedido> crearPedido(Pedido pedido);
  Future<void> actualizarEstado(String id, EstadoPedido estado);
}
```

- [ ] **Step 2: Crear mock de direcciones**

```dart
// lib/features/pedidos/data/repositories/direcciones_repository_mock.dart
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/repositories/direcciones_repository.dart';

class DireccionesRepositoryMock implements DireccionesRepository {
  final List<Direccion> _direcciones = [
    const Direccion(
      id: 'dir1',
      etiqueta: 'Casa',
      direccionTexto: 'Calle Los Rosales 123, Urb. San Eduardo',
      lat: -5.1783,
      lng: -80.6549,
      referencia: 'Portón verde',
    ),
    const Direccion(
      id: 'dir2',
      etiqueta: 'Trabajo',
      direccionTexto: 'Av. Grau 742, Of. 3B',
      lat: -5.1850,
      lng: -80.6480,
      referencia: 'Edificio corporativo',
    ),
  ];

  @override
  Future<List<Direccion>> getDirecciones() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_direcciones);
  }

  @override
  Future<Direccion> crear(Direccion direccion) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final nueva = direccion.copyWith(id: 'dir${DateTime.now().millisecondsSinceEpoch}');
    _direcciones.add(nueva);
    return nueva;
  }

  @override
  Future<Direccion> actualizar(Direccion direccion) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final idx = _direcciones.indexWhere((d) => d.id == direccion.id);
    if (idx >= 0) _direcciones[idx] = direccion;
    return direccion;
  }

  @override
  Future<void> eliminar(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _direcciones.removeWhere((d) => d.id == id);
  }
}
```

- [ ] **Step 3: Crear mock de pedidos**

```dart
// lib/features/pedidos/data/repositories/pedidos_repository_mock.dart
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/catalogo/data/repositories/catalogo_repository_mock.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/repositories/pedidos_repository.dart';

class PedidosRepositoryMock implements PedidosRepository {
  final List<Pedido> _pedidos = _buildPedidosIniciales();

  static List<Pedido> _buildPedidosIniciales() {
    final productos = CatalogoRepositoryMock();
    final now = DateTime.now();
    return [
      Pedido(
        id: 'ped001',
        negocioId: 'n1',
        items: const [
          ItemCarrito(producto: Producto(id: 'p1', negocioId: 'n1', nombre: '1/4 Pollo + papas + gaseosa', precioEnCentavos: 1890, disponible: true), cantidad: 2),
          ItemCarrito(producto: Producto(id: 'p5', negocioId: 'n1', nombre: 'Inca Kola 1.5L', precioEnCentavos: 800, disponible: true), cantidad: 1),
        ],
        estado: EstadoPedido.entregado,
        metodoPago: MetodoPago.yape,
        subtotalEnCentavos: 4580,
        costoEnvioEnCentavos: 300,
        totalEnCentavos: 4880,
        direccionEntrega: const Direccion(id: 'dir1', etiqueta: 'Casa', direccionTexto: 'Calle Los Rosales 123', lat: -5.1783, lng: -80.6549, referencia: 'Portón verde'),
        creadoEn: now.subtract(const Duration(hours: 2)),
        clienteNombre: 'María Ríos',
        clienteTelefono: '949123456',
      ),
      Pedido(
        id: 'ped002',
        negocioId: 'n2',
        items: const [
          ItemCarrito(producto: Producto(id: 'p7', negocioId: 'n2', nombre: 'Paracetamol 500mg x10', precioEnCentavos: 350, disponible: true), cantidad: 1),
          ItemCarrito(producto: Producto(id: 'p8', negocioId: 'n2', nombre: 'Vitamina C 1000mg x30', precioEnCentavos: 1890, disponible: true), cantidad: 1),
        ],
        estado: EstadoPedido.entregado,
        metodoPago: MetodoPago.efectivo,
        subtotalEnCentavos: 2240,
        costoEnvioEnCentavos: 250,
        totalEnCentavos: 2490,
        direccionEntrega: const Direccion(id: 'dir1', etiqueta: 'Casa', direccionTexto: 'Calle Los Rosales 123', lat: -5.1783, lng: -80.6549),
        creadoEn: now.subtract(const Duration(days: 1)),
        clienteNombre: 'María Ríos',
      ),
      Pedido(
        id: 'ped003',
        negocioId: 'n1',
        items: const [
          ItemCarrito(producto: Producto(id: 'p2', negocioId: 'n1', nombre: '1/2 Pollo + papas + gaseosa', precioEnCentavos: 3290, disponible: true), cantidad: 1),
        ],
        estado: EstadoPedido.enCamino,
        metodoPago: MetodoPago.yape,
        subtotalEnCentavos: 3290,
        costoEnvioEnCentavos: 300,
        totalEnCentavos: 3590,
        direccionEntrega: const Direccion(id: 'dir2', etiqueta: 'Trabajo', direccionTexto: 'Av. Grau 742, Of. 3B', lat: -5.1850, lng: -80.6480),
        creadoEn: now.subtract(const Duration(minutes: 20)),
        clienteNombre: 'María Ríos',
      ),
    ];
  }

  @override
  Future<List<Pedido>> getMisPedidos() async {
    await Future.delayed(const Duration(milliseconds: 600));
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
    await Future.delayed(const Duration(milliseconds: 500));
    _pedidos.insert(0, pedido);
    return pedido;
  }

  @override
  Future<void> actualizarEstado(String id, EstadoPedido estado) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final idx = _pedidos.indexWhere((p) => p.id == id);
    if (idx >= 0) {
      _pedidos[idx] = _pedidos[idx].copyWith(estado: estado);
    }
  }
}
```

- [ ] **Step 4: Crear DireccionesController**

```dart
// lib/features/pedidos/presentation/providers/direcciones_controller.dart
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
    final repo = DireccionesRepositoryMock();
    await repo.crear(direccion);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }

  Future<void> actualizar(Direccion direccion) async {
    final repo = DireccionesRepositoryMock();
    await repo.actualizar(direccion);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }

  Future<void> eliminar(String id) async {
    final repo = DireccionesRepositoryMock();
    await repo.eliminar(id);
    state = AsyncData(DireccionesState.loaded(await repo.getDirecciones()));
  }
}
```

- [ ] **Step 5: Crear providers de pedidos**

```dart
// lib/features/pedidos/presentation/providers/pedidos_providers.dart
import 'package:ligerito/features/pedidos/data/repositories/pedidos_repository_mock.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/domain/repositories/pedidos_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pedidos_providers.g.dart';

@Riverpod(keepAlive: true)
PedidosRepository pedidosRepository(Ref ref) => PedidosRepositoryMock();

@riverpod
Future<List<Pedido>> misPedidos(Ref ref) {
  final repo = ref.watch(pedidosRepositoryProvider);
  return repo.getMisPedidos();
}

@riverpod
Future<Pedido?> pedidoDetalle(Ref ref, String id) {
  final repo = ref.watch(pedidosRepositoryProvider);
  return repo.getPedido(id);
}
```

- [ ] **Step 6: Correr code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 7: Commit**

```bash
git add lib/features/pedidos/
git commit -m "feat(pedidos): add mock repos and providers for orders and addresses"
```

---

### Task 3: Carrito Controller

**Files:**
- Create: `lib/features/carrito/presentation/providers/carrito_controller.dart`

**Interfaces:**
- Consumes: `Producto`, `ItemCarrito`, `ResultadoAgregar`
- Produces: `carritoControllerProvider` con metodos `agregar()`, `cambiarCantidad()`, `eliminarItem()`, `vaciar()`, `totalEnCentavos`, `negocioId`

- [ ] **Step 1: Crear CarritoController**

```dart
// lib/features/carrito/presentation/providers/carrito_controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';
import 'package:ligerito/features/carrito/domain/entities/resultado_agregar.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'carrito_controller.freezed.dart';
part 'carrito_controller.g.dart';

@freezed
class CarritoState with _$CarritoState {
  const factory CarritoState({
    @Default([]) List<ItemCarrito> items,
    String? negocioId,
    String? negocioNombre,
  }) = _CarritoState;
}

@Riverpod(keepAlive: true)
class CarritoController extends _$CarritoController {
  @override
  CarritoState build() => const CarritoState();

  ResultadoAgregar agregar(Producto producto, {String? negocioNombre}) {
    final current = state;
    if (current.negocioId != null && current.negocioId != producto.negocioId) {
      return ResultadoAgregar.conflictoNegocio;
    }
    final items = List<ItemCarrito>.from(current.items);
    final idx = items.indexWhere((i) => i.producto.id == producto.id);
    if (idx >= 0) {
      items[idx] = items[idx].copyWith(cantidad: items[idx].cantidad + 1);
    } else {
      items.add(ItemCarrito(producto: producto, cantidad: 1));
    }
    state = current.copyWith(
      items: items,
      negocioId: producto.negocioId,
      negocioNombre: negocioNombre,
    );
    return ResultadoAgregar.agregado;
  }

  void cambiarCantidad(String productoId, int cantidad) {
    final current = state;
    if (cantidad <= 0) {
      eliminarItem(productoId);
      return;
    }
    final items = current.items.map((i) {
      if (i.producto.id == productoId) {
        return i.copyWith(cantidad: cantidad);
      }
      return i;
    }).toList();
    state = current.copyWith(items: items);
  }

  void eliminarItem(String productoId) {
    final current = state;
    final items = current.items.where((i) => i.producto.id != productoId).toList();
    if (items.isEmpty) {
      state = const CarritoState();
    } else {
      state = current.copyWith(items: items);
    }
  }

  void vaciar() {
    state = const CarritoState();
  }

  int get subtotalEnCentavos =>
      state.items.fold(0, (sum, i) => sum + i.subtotalEnCentavos);
}
```

- [ ] **Step 2: Correr code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 3: Commit**

```bash
git add lib/features/carrito/
git commit -m "feat(carrito): add CarritoController with add/remove/clear operations"
```

---

### Task 4: Home Screen + NegocioCard Widget

**Files:**
- Create: `lib/features/catalogo/presentation/widgets/negocio_card.dart`
- Create: `lib/features/catalogo/presentation/screens/home_screen.dart`
- Modify: `lib/core/router/app_router.dart:66-67` (replace placeholder)

- [ ] **Step 1: Crear NegocioCard widget**

```dart
// lib/features/catalogo/presentation/widgets/negocio_card.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/catalogo/domain/entities/negocio.dart';

class NegocioCard extends StatelessWidget {
  final Negocio negocio;
  final VoidCallback? onTap;

  const NegocioCard({super.key, required this.negocio, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: negocio.abierto ? 1.0 : 0.55,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: LigeritoColors.surface,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                Expanded(child: _buildInfo()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final iniciales = _getIniciales();
    final colorIndex = negocio.nombre.hashCode % _gradientColors.length;
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradientColors[colorIndex],
        ),
      ),
      child: Center(
        child: Text(
          iniciales,
          style: LigeritoTextStyles.heading2.copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(negocio.nombre, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: [
            _buildBadge(),
            _buildRating(),
            _buildTiempo(),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Envío S/ ${negocio.costoEnvioBase.toStringAsFixed(2)} · Mín. S/ ${negocio.pedidoMinimo.toStringAsFixed(2)}',
          style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildBadge() {
    final abierto = negocio.abierto;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: abierto ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        abierto ? 'Abierto' : 'Cerrado',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: abierto ? const Color(0xFF2E7D32) : const Color(0xFFC62828)),
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 14, color: LigeritoColors.warning),
        const SizedBox(width: 2),
        Text(negocio.calificacion.toStringAsFixed(1), style: LigeritoTextStyles.body.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildTiempo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.access_time_rounded, size: 12, color: LigeritoColors.textSecondary),
        const SizedBox(width: 2),
        Text('~${negocio.tiempoEstimadoMin} min', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
      ],
    );
  }

  String _getIniciales() {
    final words = negocio.nombre.split(' ').take(2).toList();
    return words.map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').join();
  }

  static final List<List<Color>> _gradientColors = [
    [LigeritoColors.primary, const Color(0xFFFF6B6B)],
    [LigeritoColors.secondary, const Color(0xFF66BB6A)],
    [const Color(0xFF1976D2), const Color(0xFF42A5F5)],
    [const Color(0xFF7B1FA2), const Color(0xFFAB47BC)],
    [const Color(0xFFE65100), const Color(0xFFFF9800)],
    [const Color(0xFF00838F), const Color(0xFF26C6DA)],
  ];
}
```

- [ ] **Step 2: Crear HomeScreen**

```dart
// lib/features/catalogo/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/catalogo/presentation/providers/catalogo_providers.dart';
import 'package:ligerito/features/catalogo/presentation/widgets/negocio_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _searchQuery = '';
  String _categoriaSeleccionada = 'todos';

  static const _categorias = [
    ('todos', 'Todos'),
    ('restaurante', 'Restaurantes'),
    ('farmacia', 'Farmacias'),
    ('mercado', 'Mercados'),
    ('ferreteria', 'Ferreterías'),
  ];

  @override
  Widget build(BuildContext context) {
    final negociosAsync = ref.watch(negociosProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryChips(),
            Expanded(child: _buildBody(negociosAsync)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('¿Qué se te antoja hoy?', style: LigeritoTextStyles.heading1),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (q) => setState(() => _searchQuery = q),
        decoration: InputDecoration(
          hintText: 'Busca pollerías, farmacias...',
          prefixIcon: const Icon(Icons.search_rounded, color: LigeritoColors.textSecondary),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (id, label) = _categorias[index];
          final selected = _categoriaSeleccionada == id;
          return ChoiceChip(
            label: Text(label),
            selected: selected,
            onSelected: (_) => setState(() => _categoriaSeleccionada = id),
            selectedColor: LigeritoColors.primary,
            backgroundColor: const Color(0xFFF0F0F0),
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : LigeritoColors.textPrimary,
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }

  Widget _buildBody(AsyncValue negociosAsync) {
    return negociosAsync.when(
      loading: () => const LigeritoListSkeleton(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (negocios) {
        final filtrados = negocios.where((n) {
          final matchCategoria = _categoriaSeleccionada == 'todos' || n.categoria == _categoriaSeleccionada;
          final matchSearch = _searchQuery.isEmpty || n.nombre.toLowerCase().contains(_searchQuery.toLowerCase());
          return matchCategoria && matchSearch;
        }).toList();

        if (filtrados.isEmpty) {
          return const EmptyStateView(
            icon: Icons.storefront_rounded,
            title: 'Ningún negocio cerca abierto por ahora',
            subtitle: 'Intenta con otra categoría o vuelve pronto',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtrados.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final negocio = filtrados[index];
            return NegocioCard(
              negocio: negocio,
              onTap: () => context.push('/negocio/${negocio.id}'),
            );
          },
        );
      },
    );
  }
}
```

- [ ] **Step 3: Actualizar router para HomeScreen**

En `lib/core/router/app_router.dart`, reemplazar el placeholder de `/home`:

```dart
// Cambiar línea ~66-67 de:
//   builder: (context, state) => const ModuloPlaceholderScreen(nombre: 'home'),
// a:
builder: (context, state) => const HomeScreen(),
```

Agregar import al inicio del archivo:
```dart
import 'package:ligerito/features/catalogo/presentation/screens/home_screen.dart';
```

- [ ] **Step 4: Verificar que compila**

```bash
flutter analyze
```

- [ ] **Step 5: Commit**

```bash
git add lib/features/catalogo/presentation/ lib/core/router/app_router.dart
git commit -m "feat(home): add HomeScreen with search, categories, and NegocioCard"
```

---

### Task 5: Detalle de Negocio Screen + ProductoCard

**Files:**
- Create: `lib/features/catalogo/presentation/widgets/producto_card.dart`
- Create: `lib/features/catalogo/presentation/screens/negocio_screen.dart`
- Modify: `lib/core/router/app_router.dart:99-101` (replace placeholder)

- [ ] **Step 1: Crear ProductoCard**

```dart
// lib/features/catalogo/presentation/widgets/producto_card.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback? onTap;

  const ProductoCard({super.key, required this.producto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: producto.disponible ? 1.0 : 0.5,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: LigeritoColors.surface,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(producto.nombre, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                      if (producto.descripcion != null) ...[
                        const SizedBox(height: 2),
                        Text(producto.descripcion!, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
                      ],
                      const SizedBox(height: 6),
                      Text(
                        CurrencyFormatter.formatoPen(producto.precioEnCentavos),
                        style: LigeritoTextStyles.price,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFF5F5F5),
                  ),
                  child: Center(
                    child: Icon(Icons.image_rounded, color: LigeritoColors.textSecondary.withOpacity(0.5), size: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Crear NegocioScreen**

```dart
// lib/features/catalogo/presentation/screens/negocio_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/catalogo/presentation/providers/catalogo_providers.dart';
import 'package:ligerito/features/catalogo/presentation/widgets/producto_card.dart';

class NegocioScreen extends ConsumerWidget {
  final String negocioId;

  const NegocioScreen({super.key, required this.negocioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final negocioAsync = ref.watch(negocioProvider(negocioId));
    final productosAsync = ref.watch(productosNegocioProvider(negocioId));

    return Scaffold(
      appBar: AppBar(
        title: negocioAsync.whenOrNull(data: (n) => Text(n?.nombre ?? '')) ?? const Text(''),
      ),
      body: negocioAsync.when(
        loading: () => const LigeritoListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (negocio) {
          if (negocio == null) return const Center(child: Text('Negocio no encontrado'));
          return Column(
            children: [
              _buildHeader(negocio),
              Expanded(child: _buildMenu(productosAsync)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(negocio) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: LigeritoColors.surface,
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          _buildBadge(negocio.abierto),
          _buildRating(negocio.calificacion),
          _buildInfoChip(Icons.access_time_rounded, '~${negocio.tiempoEstimadoMin} min'),
          _buildInfoChip(Icons.delivery_dining_rounded, 'Envío S/ ${negocio.costoEnvioBase.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildBadge(bool abierto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: abierto ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        abierto ? 'Abierto' : 'Cerrado',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: abierto ? const Color(0xFF2E7D32) : const Color(0xFFC62828)),
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rounded, size: 14, color: LigeritoColors.warning),
        const SizedBox(width: 2),
        Text(rating.toStringAsFixed(1), style: LigeritoTextStyles.body.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: LigeritoColors.textSecondary),
        const SizedBox(width: 2),
        Text(text, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildMenu(AsyncValue productosAsync) {
    return productosAsync.when(
      loading: () => const LigeritoListSkeleton(),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (productos) {
        final secciones = <String, List>{};
        for (final p in productos) {
          final seccion = p.seccionMenu ?? 'Otros';
          secciones.putIfAbsent(seccion, () => []).add(p);
        }
        if (secciones.isEmpty) {
          return const Center(child: Text('Este negocio aún no tiene productos'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: secciones.length,
          itemBuilder: (context, index) {
            final entry = secciones.entries.toList()[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(entry.key, style: LigeritoTextStyles.heading2.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
                ...entry.value.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ProductoCard(producto: p),
                )),
                const SizedBox(height: 8),
              ],
            );
          },
        );
      },
    );
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/negocio/:id`:
```dart
GoRoute(
  path: '/negocio/:id',
  builder: (context, state) => NegocioScreen(negocioId: state.pathParameters['id']!),
),
```

Agregar import:
```dart
import 'package:ligerito/features/catalogo/presentation/screens/negocio_screen.dart';
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/catalogo/presentation/ lib/core/router/app_router.dart
git commit -m "feat(negocio): add NegocioScreen with menu grouped by sections"
```

---

### Task 6: Carrito Screen + CartItemTile

**Files:**
- Create: `lib/features/carrito/presentation/widgets/cart_item_tile.dart`
- Create: `lib/features/carrito/presentation/screens/carrito_screen.dart`
- Modify: `lib/core/router/app_router.dart:103-106`

- [ ] **Step 1: Crear CartItemTile**

```dart
// lib/features/carrito/presentation/widgets/cart_item_tile.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';

class CartItemTile extends StatelessWidget {
  final ItemCarrito item;
  final ValueChanged<int> onCantidadChanged;

  const CartItemTile({super.key, required this.item, required this.onCantidadChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: LigeritoColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.producto.nombre, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                  if (item.notas != null && item.notas!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(item.notas!, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12, fontStyle: FontStyle.italic)),
                  ],
                  const SizedBox(height: 6),
                  Text(CurrencyFormatter.formatoPen(item.subtotalEnCentavos), style: LigeritoTextStyles.price),
                ],
              ),
            ),
            _buildCounter(),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCounterButton(Icons.remove, false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('${item.cantidad}', style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15)),
        ),
        _buildCounterButton(Icons.add, true),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, bool primary) {
    return InkWell(
      onTap: () {
        final nuevaCantidad = primary ? item.cantidad + 1 : item.cantidad - 1;
        onCantidadChanged(nuevaCantidad);
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primary ? LigeritoColors.primary : Colors.transparent,
          border: primary ? null : Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        ),
        child: Icon(icon, size: 16, color: primary ? Colors.white : LigeritoColors.textSecondary),
      ),
    );
  }
}
```

- [ ] **Step 2: Crear CarritoScreen**

```dart
// lib/features/carrito/presentation/screens/carrito_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/features/carrito/presentation/providers/carrito_controller.dart';
import 'package:ligerito/features/carrito/presentation/widgets/cart_item_tile.dart';

class CarritoScreen extends ConsumerWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoControllerProvider);
    final controller = ref.read(carritoControllerProvider.notifier);

    if (carrito.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tu pedido')),
        body: const EmptyStateView(
          icon: Icons.shopping_cart_rounded,
          title: 'Tu carrito está vacío',
          subtitle: 'Agrega algo rico de un negocio',
        ),
      );
    }

    final subtotal = controller.subtotalEnCentavos;
    final costoEnvio = 300; // TODO: obtener del negocio
    final total = subtotal + costoEnvio;

    return Scaffold(
      appBar: AppBar(title: const Text('Tu pedido')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: LigeritoColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(carrito.negocioNombre ?? '', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 13)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: carrito.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = carrito.items[index];
                return CartItemTile(
                  item: item,
                  onCantidadChanged: (cant) => controller.cambiarCantidad(item.producto.id, cant),
                );
              },
            ),
          ),
          _buildResumen(subtotal, costoEnvio, total, context),
        ],
      ),
    );
  }

  Widget _buildResumen(int subtotal, int costoEnvio, int total, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildRow('Subtotal', CurrencyFormatter.formatoPen(subtotal)),
                  const SizedBox(height: 6),
                  _buildRow('Envío', CurrencyFormatter.formatoPen(costoEnvio)),
                  const Divider(height: 20),
                  _buildRow('Total', CurrencyFormatter.formatoPen(total), bold: true, color: LigeritoColors.primary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          LigeritoButton(
            label: 'Continuar',
            onPressed: () => context.push('/checkout'),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool bold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: LigeritoTextStyles.bodySecondary),
        Text(value, style: LigeritoTextStyles.body.copyWith(
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          color: color,
          fontSize: bold ? 16 : 14,
        )),
      ],
    );
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/carrito`:
```dart
GoRoute(
  path: '/carrito',
  builder: (context, state) => const CarritoScreen(),
),
```

Agregar import:
```dart
import 'package:ligerito/features/carrito/presentation/screens/carrito_screen.dart';
```

- [ ] **Step 4: Commit**

```bash
git add lib/features/carrito/presentation/ lib/core/router/app_router.dart
git commit -m "feat(carrito): add CarritoScreen with items, counter, and summary"
```

---

### Task 7: Checkout Screen + PaymentMethodSelector

**Files:**
- Create: `lib/features/carrito/presentation/widgets/payment_method_selector.dart`
- Create: `lib/features/carrito/presentation/screens/checkout_screen.dart`
- Modify: `lib/core/router/app_router.dart:107-110`

- [ ] **Step 1: Crear PaymentMethodSelector**

```dart
// lib/features/carrito/presentation/widgets/payment_method_selector.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';

class PaymentMethodSelector extends StatelessWidget {
  final MetodoPago? selected;
  final ValueChanged<MetodoPago> onSelected;

  const PaymentMethodSelector({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOption(MetodoPago.yape, 'Yape', 'Yapea al 949 123 456', const Color(0xFF6C3FC7), Icons.payment_rounded, 'Y'),
        const SizedBox(height: 8),
        _buildOption(MetodoPago.plin, 'Plin', 'Plin al 949 123 456', const Color(0xFF00A859), Icons.payment_rounded, 'P'),
        const SizedBox(height: 8),
        _buildOption(MetodoPago.efectivo, 'Efectivo', 'Paga al recibir', const Color(0xFFF5F5F5), Icons.money_rounded, null),
      ],
    );
  }

  Widget _buildOption(MetodoPago metodo, String title, String subtitle, Color color, IconData fallbackIcon, String? letter) {
    final isSelected = selected == metodo;
    return InkWell(
      onTap: () => onSelected(metodo),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? LigeritoColors.primary : const Color(0xFFE0E0E0), width: isSelected ? 1.5 : 1),
          color: isSelected ? const Color(0xFFFFF5F5) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              child: Center(
                child: letter != null
                    ? Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))
                    : Icon(fallbackIcon, color: LigeritoColors.textSecondary, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                  Text(subtitle, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: LigeritoColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Crear CheckoutScreen**

```dart
// lib/features/carrito/presentation/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/features/carrito/presentation/providers/carrito_controller.dart';
import 'package:ligerito/features/carrito/presentation/widgets/payment_method_selector.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';
import 'package:ligerito/features/pedidos/presentation/providers/direcciones_controller.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  Direccion? _direccionSeleccionada;
  MetodoPago? _metodoPago;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final direccionesState = ref.watch(direccionesControllerProvider);
    final carrito = ref.watch(carritoControllerProvider);
    final subtotal = carrito.subtotalEnCentavos;
    final costoEnvio = 300;
    final total = subtotal + costoEnvio;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DIRECCIÓN DE ENTREGA', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            _buildDireccionSelector(direccionesState),
            const SizedBox(height: 20),
            Text('MÉTODO DE PAGO', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            PaymentMethodSelector(selected: _metodoPago, onSelected: (m) => setState(() => _metodoPago = m)),
            const SizedBox(height: 16),
            _buildResumen(subtotal, costoEnvio, total),
            const Spacer(),
            LigeritoButton(
              label: 'Confirmar pedido',
              loading: _loading,
              onPressed: (_direccionSeleccionada == null || _metodoPago == null) ? null : _confirmarPedido,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDireccionSelector(AsyncValue direccionesState) {
    return direccionesState.whenOrNull(
          data: (state) => state.when(
            cargando: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
            loaded: (direcciones) => _buildDireccionList(direcciones),
            error: (_) => const Text('Error al cargar direcciones'),
          ),
        ) ??
        const SizedBox();
  }

  Widget _buildDireccionList(List<Direccion> direcciones) {
    return Column(
      children: direcciones.map((d) {
        final selected = _direccionSeleccionada?.id == d.id;
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: LigeritoColors.surface,
          child: InkWell(
            onTap: () => setState(() => _direccionSeleccionada = d),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: selected ? LigeritoColors.primary : Colors.transparent, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, size: 20, color: LigeritoColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.etiqueta, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                        Text(d.direccionTexto, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 13)),
                        if (d.referencia != null) Text('Ref: ${d.referencia}', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12, color: const Color(0xFF9E9E9E))),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFFBDBDBD)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResumen(int subtotal, int costoEnvio, int total) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Subtotal', style: LigeritoTextStyles.bodySecondary),
              Text(CurrencyFormatter.formatoPen(subtotal)),
            ]),
            const SizedBox(height: 6),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Envío', style: LigeritoTextStyles.bodySecondary),
              Text(CurrencyFormatter.formatoPen(costoEnvio)),
            ]),
            const Divider(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total', style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
              Text(CurrencyFormatter.formatoPen(total), style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: LigeritoColors.primary)),
            ]),
          ],
        ),
      ),
    );
  }

  void _confirmarPedido() async {
    setState(() => _loading = true);
    // TODO: Crear pedido via pedidosRepository
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ref.read(carritoControllerProvider.notifier).vaciar();
      context.go('/historial');
    }
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/checkout` y agregar import de `CheckoutScreen`.

- [ ] **Step 4: Commit**

```bash
git add lib/features/carrito/presentation/ lib/core/router/app_router.dart
git commit -m "feat(checkout): add CheckoutScreen with address selector and payment methods"
```

---

### Task 8: Seguimiento de Pedido Screen + EstadoPedidoTimeline

**Files:**
- Create: `lib/features/pedidos/presentation/widgets/estado_pedido_timeline.dart`
- Create: `lib/features/pedidos/presentation/screens/pedido_screen.dart`
- Modify: `lib/core/router/app_router.dart:111-116`

- [ ] **Step 1: Crear EstadoPedidoTimeline**

```dart
// lib/features/pedidos/presentation/widgets/estado_pedido_timeline.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';

class EstadoPedidoTimeline extends StatelessWidget {
  final EstadoPedido estadoActual;
  final Map<EstadoPedido, String>? timestamps;

  const EstadoPedidoTimeline({super.key, required this.estadoActual, this.timestamps});

  static const _estados = [
    EstadoPedido.pendiente,
    EstadoPedido.confirmado,
    EstadoPedido.preparando,
    EstadoPedido.enCamino,
    EstadoPedido.entregado,
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _estados.indexOf(estadoActual);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(_estados.length * 2 - 1, (i) {
            if (i.isOdd) return _buildLine(i ~/ 2, currentIndex);
            return _buildDot(i ~/ 2, currentIndex);
          }),
        ),
      ),
    );
  }

  Widget _buildDot(int index, int currentIndex) {
    final estado = _estados[index];
    final isDone = index < currentIndex;
    final isCurrent = index == currentIndex;
    final isPending = index > currentIndex;

    Color dotColor;
    if (isDone) dotColor = LigeritoColors.secondary;
    else if (isCurrent) dotColor = LigeritoColors.primary;
    else dotColor = const Color(0xFFE0E0E0);

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPending ? Colors.transparent : dotColor,
            border: isPending ? Border.all(color: const Color(0xFFE0E0E0), width: 2) : null,
            boxShadow: isCurrent ? [BoxShadow(color: LigeritoColors.primary.withOpacity(0.2), blurRadius: 8, spreadRadius: 2)] : null,
          ),
          child: isDone ? const Icon(Icons.check_rounded, size: 12, color: Colors.white) : null,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            _labelFor(estado),
            style: LigeritoTextStyles.body.copyWith(
              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
              color: isPending ? const Color(0xFF9E9E9E) : LigeritoColors.textPrimary,
            ),
          ),
        ),
        if (timestamps != null && timestamps![estado] != null)
          Text(timestamps![estado]!, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildLine(int index, int currentIndex) {
    final isDone = index < currentIndex;
    final isTransitioning = index == currentIndex - 1;

    return Container(
      width: 2,
      height: 20,
      margin: const EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
        gradient: isTransitioning
            ? LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [LigeritoColors.secondary, isDone ? LigeritoColors.secondary : const Color(0xFFE0E0E0)])
            : null,
        color: isDone ? LigeritoColors.secondary : const Color(0xFFE0E0E0),
      ),
    );
  }

  String _labelFor(EstadoPedido estado) {
    return switch (estado) {
      EstadoPedido.pendiente => 'Pendiente',
      EstadoPedido.confirmado => 'Confirmado',
      EstadoPedido.preparando => 'Preparando',
      EstadoPedido.enCamino => 'En camino',
      EstadoPedido.entregado => 'Entregado',
      EstadoPedido.cancelado => 'Cancelado',
    };
  }
}
```

- [ ] **Step 2: Crear PedidoScreen**

```dart
// lib/features/pedidos/presentation/screens/pedido_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/pedidos/presentation/providers/pedidos_providers.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/estado_pedido_timeline.dart';
import 'package:url_launcher/url_launcher.dart';

class PedidoScreen extends ConsumerWidget {
  final String pedidoId;

  const PedidoScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidoAsync = ref.watch(pedidoDetalleProvider(pedidoId));

    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento')),
      body: pedidoAsync.when(
        loading: () => const LigeritoListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (pedido) {
          if (pedido == null) return const Center(child: Text('Pedido no encontrado'));
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildHeader(context),
                const SizedBox(height: 24),
                EstadoPedidoTimeline(estadoActual: pedido.estado),
                const Spacer(),
                LigeritoButton(
                  label: 'Contactar al negocio',
                  variant: LigeritoButtonVariant.outline,
                  onPressed: () => _contactarWhatsApp(context, pedidoId),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LigeritoColors.primary.withOpacity(0.1),
          ),
          child: const Icon(Icons.delivery_dining_rounded, size: 32, color: LigeritoColors.primary),
        ),
        const SizedBox(height: 12),
        Text('¡Ya casi llega, ligerito!', style: LigeritoTextStyles.heading1),
        const SizedBox(height: 4),
        Text('Pedido #$pedidoId', style: LigeritoTextStyles.bodySecondary),
      ],
    );
  }

  void _contactarWhatsApp(BuildContext context, String pedidoId) async {
    final msg = Uri.encodeComponent('Hola, consulto por mi pedido #$pedidoId en Ligerito');
    final uri = Uri.parse('https://wa.me/?text=$msg');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/pedido/:id` y agregar import.

- [ ] **Step 4: Commit**

```bash
git add lib/features/pedidos/presentation/ lib/core/router/app_router.dart
git commit -m "feat(pedido): add PedidoScreen with EstadoPedidoTimeline and WhatsApp contact"
```

---

### Task 9: Historial Screen + PedidoResumenCard

**Files:**
- Create: `lib/features/pedidos/presentation/widgets/pedido_resumen_card.dart`
- Create: `lib/features/pedidos/presentation/screens/historial_screen.dart`
- Modify: `lib/core/router/app_router.dart:72-76`

- [ ] **Step 1: Crear PedidoResumenCard**

```dart
// lib/features/pedidos/presentation/widgets/pedido_resumen_card.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/utils/date_formatter.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';

class PedidoResumenCard extends StatelessWidget {
  final Pedido pedido;
  final String nombreNegocio;
  final VoidCallback? onTap;
  final VoidCallback? onRepetir;

  const PedidoResumenCard({
    super.key,
    required this.pedido,
    required this.nombreNegocio,
    this.onTap,
    this.onRepetir,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = pedido.estado != EstadoPedido.entregado && pedido.estado != EstadoPedido.cancelado;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isActive ? const BorderSide(color: LigeritoColors.primary, width: 1.5) : BorderSide.none,
      ),
      color: LigeritoColors.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nombreNegocio, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('Pedido #${_shortId(pedido.id)} · ${DateFormatter.tiempoTranscurrido(pedido.creadoEn)}', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(pedido.items.map((i) => i.producto.nombre).join(', '), style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(CurrencyFormatter.formatoPen(pedido.totalEnCentavos), style: LigeritoTextStyles.price),
                      const SizedBox(height: 4),
                      _buildBadge(),
                    ],
                  ),
                ],
              ),
              if (onRepetir != null) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onRepetir,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    side: const BorderSide(color: LigeritoColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Repetir pedido', style: TextStyle(color: LigeritoColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final iniciales = nombreNegocio.split(' ').take(2).map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: LigeritoColors.primary),
      child: Center(child: Text(iniciales, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w700))),
    );
  }

  Widget _buildBadge() {
    final (label, color) = switch (pedido.estado) {
      EstadoPedido.entregado => ('Entregado', const Color(0xFF2E7D32)),
      EstadoPedido.cancelado => ('Cancelado', const Color(0xFFC62828)),
      EstadoPedido.enCamino => ('En camino', const Color(0xFF1565C0)),
      EstadoPedido.preparando => ('Preparando', const Color(0xFFE65100)),
      EstadoPedido.confirmado => ('Confirmado', const Color(0xFF1565C0)),
      EstadoPedido.pendiente => ('Pendiente', const Color(0xFFE65100)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(100)),
      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }

  String _shortId(String id) => id.replaceAll('ped', '');
}
```

- [ ] **Step 2: Crear HistorialScreen**

```dart
// lib/features/pedidos/presentation/screens/historial_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/presentation/providers/pedidos_providers.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/pedido_resumen_card.dart';

class HistorialScreen extends ConsumerWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosAsync = ref.watch(misPedidosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis pedidos'), centerTitle: true),
      body: pedidosAsync.when(
        loading: () => const LigeritoListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (pedidos) {
          if (pedidos.isEmpty) {
            return const EmptyStateView(
              icon: Icons.receipt_long_rounded,
              title: 'Aún no tienes pedidos',
              subtitle: 'Tu primer pedido te espera, ligerito',
            );
          }
          final activos = pedidos.where((p) => p.estado != EstadoPedido.entregado && p.estado != EstadoPedido.cancelado).toList();
          final entregados = pedidos.where((p) => p.estado == EstadoPedido.entregado).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...activos.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PedidoResumenCard(
                  pedido: p,
                  nombreNegocio: _nombreNegocio(p.negocioId),
                  onTap: () => context.push('/pedido/${p.id}'),
                ),
              )),
              ...entregados.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PedidoResumenCard(
                  pedido: p,
                  nombreNegocio: _nombreNegocio(p.negocioId),
                  onRepetir: () { /* TODO: agregar items al carrito */ },
                ),
              )),
            ],
          );
        },
      ),
    );
  }

  String _nombreNegocio(String negocioId) {
    return switch (negocioId) {
      'n1' => 'Pollería El Picanterón',
      'n2' => 'Farmacia San Pablo',
      'n3' => 'Mercado Central Piura',
      'n5' => 'Cevichería La Boca',
      _ => 'Negocio',
    };
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/historial` y agregar import.

- [ ] **Step 4: Commit**

```bash
git add lib/features/pedidos/presentation/ lib/core/router/app_router.dart
git commit -m "feat(historial): add HistorialScreen with PedidoResumenCard and repeat order"
```

---

### Task 10: Perfil Screen

**Files:**
- Create: `lib/features/auth/presentation/screens/perfil_screen.dart`
- Modify: `lib/core/router/app_router.dart:81-95`

- [ ] **Step 1: Crear PerfilScreen**

```dart
// lib/features/auth/presentation/screens/perfil_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';

class PerfilScreen extends ConsumerWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sesion = ref.watch(sesionControllerProvider);
    final usuario = sesion.valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil'), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 24),
          _buildAvatar(usuario?.whenOrNull(autenticado: (u) => u) != null ? usuario!.value!.nombre : ''),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _buildListTile(
                    icon: Icons.location_on_rounded,
                    iconColor: LigeritoColors.primary,
                    title: 'Mis direcciones',
                    onTap: () => context.push('/perfil/direcciones'),
                  ),
                  const Divider(height: 1, indent: 52),
                  _buildListTile(
                    icon: Icons.person_rounded,
                    iconColor: LigeritoColors.primary,
                    title: 'Mis datos',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFFFEBEE), width: 1.5),
              ),
              child: InkWell(
                onTap: () => _confirmarCerrarSesion(context, ref),
                borderRadius: BorderRadius.circular(16),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('Cerrar sesión', style: TextStyle(color: LigeritoColors.error, fontWeight: FontWeight.w500, fontSize: 14))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String nombre) {
    final iniciales = nombre.split(' ').take(2).map((w) => w.isNotEmpty ? w[0] : '').join().toUpperCase();
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [LigeritoColors.primary, LigeritoColors.primaryDark]),
      ),
      child: Center(child: Text(iniciales, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700))),
    );
  }

  Widget _buildListTile({required IconData icon, required Color iconColor, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 20),
      title: Text(title, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 16, color: Color(0xFFBDBDBD)),
      onTap: onTap,
    );
  }

  void _confirmarCerrarSesion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Seguro que quieres cerrar sesión?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(sesionControllerProvider.notifier).cerrarSesion();
            },
            child: const Text('Cerrar sesión', style: TextStyle(color: LigeritoColors.error)),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Actualizar router**

Reemplazar placeholder de `/perfil` y agregar import.

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/screens/perfil_screen.dart lib/core/router/app_router.dart
git commit -m "feat(perfil): add PerfilScreen with user info, navigation, and logout"
```

---

### Task 11: Direcciones Screen + DireccionCard

**Files:**
- Create: `lib/features/pedidos/presentation/widgets/direccion_card.dart`
- Create: `lib/features/pedidos/presentation/screens/direcciones_screen.dart`
- Modify: `lib/core/router/app_router.dart:87-91`

- [ ] **Step 1: Crear DireccionCard**

```dart
// lib/features/pedidos/presentation/widgets/direccion_card.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';

class DireccionCard extends StatelessWidget {
  final Direccion direccion;
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  const DireccionCard({super.key, required this.direccion, this.onEditar, this.onEliminar});

  @override
  Widget build(BuildContext context) {
    final icon = direccion.etiqueta.toLowerCase() == 'trabajo' ? Icons.business_rounded : Icons.home_rounded;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: LigeritoColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: LigeritoColors.primary.withOpacity(0.1),
                  ),
                  child: Icon(icon, size: 18, color: LigeritoColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(direccion.etiqueta, style: LigeritoTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(direccion.direccionTexto, style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 13)),
                      if (direccion.referencia != null) Text('Ref: ${direccion.referencia}', style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12, color: const Color(0xFF9E9E9E))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(onTap: onEditar, child: const Text('Editar', style: TextStyle(fontSize: 13, color: Color(0xFF1976D2), fontWeight: FontWeight.w500))),
                const SizedBox(width: 16),
                GestureDetector(onTap: onEliminar, child: const Text('Eliminar', style: TextStyle(fontSize: 13, color: LigeritoColors.error, fontWeight: FontWeight.w500))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Crear DireccionesScreen**

```dart
// lib/features/pedidos/presentation/screens/direcciones_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/presentation/providers/direcciones_controller.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/direccion_card.dart';

class DireccionesScreen extends ConsumerWidget {
  const DireccionesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final direccionesState = ref.watch(direccionesControllerProvider);
    final controller = ref.read(direccionesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis direcciones')),
      body: Column(
        children: [
          Expanded(
            child: direccionesState.when(
              cargando: () => const LigeritoListSkeleton(),
              loaded: (direcciones) {
                if (direcciones.isEmpty) {
                  return const EmptyStateView(
                    icon: Icons.location_on_rounded,
                    title: 'No tienes direcciones guardadas',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: direcciones.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final d = direcciones[index];
                    return DireccionCard(
                      direccion: d,
                      onEditar: () => _showDialog(context, controller, d),
                      onEliminar: () => controller.eliminar(d.id),
                    );
                  },
                );
              },
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: LigeritoButton(
              label: '+ Nueva dirección',
              onPressed: () => _showDialog(context, controller, null),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, DireccionesController controller, Direccion? existente) {
    final etiquetaCtrl = TextEditingController(text: existente?.etiqueta ?? '');
    final direccionCtrl = TextEditingController(text: existente?.direccionTexto ?? '');
    final referenciaCtrl = TextEditingController(text: existente?.referencia ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existente == null ? 'Nueva dirección' : 'Editar dirección'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: etiquetaCtrl, decoration: const InputDecoration(labelText: 'Etiqueta (Casa, Trabajo)')),
            const SizedBox(height: 8),
            TextField(controller: direccionCtrl, decoration: const InputDecoration(labelText: 'Dirección')),
            const SizedBox(height: 8),
            TextField(controller: referenciaCtrl, decoration: const InputDecoration(labelText: 'Referencia (opcional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              final direccion = Direccion(
                id: existente?.id ?? '',
                etiqueta: etiquetaCtrl.text,
                direccionTexto: direccionCtrl.text,
                lat: existente?.lat ?? -5.1783,
                lng: existente?.lng ?? -80.6549,
                referencia: referenciaCtrl.text.isNotEmpty ? referenciaCtrl.text : null,
              );
              if (existente == null) {
                controller.crear(direccion);
              } else {
                controller.actualizar(direccion);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Guardar', style: TextStyle(color: LigeritoColors.primary)),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Actualizar router**

Reemplazar placeholder de `/perfil/direcciones` y agregar import.

- [ ] **Step 4: Commit**

```bash
git add lib/features/pedidos/presentation/ lib/core/router/app_router.dart
git commit -m "feat(direcciones): add DireccionesScreen with CRUD and DireccionCard"
```

---

### Task 12: Router Final Update + Bottom Nav Icons

**Files:**
- Modify: `lib/core/router/app_router.dart`

- [ ] **Step 1: Reemplazar TODOS los placeholders restantes en app_router.dart**

Asegurarse de que TODOS los `ModuloPlaceholderScreen` han sido reemplazados por sus screens reales y que todos los imports están correctos.

- [ ] **Step 2: Actualizar ClienteShell con íconos Material**

```dart
class ClienteShell extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ClienteShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_rounded), label: 'Explorar'),
          NavigationDestination(icon: Icon(Icons.receipt_long_rounded), label: 'Pedidos'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Verificar compilación completa**

```bash
flutter analyze
```

- [ ] **Step 4: Hot restart para probar todo el flujo**

```bash
flutter run
```

- [ ] **Step 5: Commit final**

```bash
git add .
git commit -m "feat(router): replace all placeholders with real screens, update nav icons"
```

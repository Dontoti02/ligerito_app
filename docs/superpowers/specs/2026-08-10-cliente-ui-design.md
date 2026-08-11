# Ligerito - Flujo Cliente UI Design Spec

**Fecha:** 2026-08-10
**Scope:** 8 screens del flujo cliente (Home, Negocio, Carrito, Checkout, Seguimiento, Historial, Perfil, Direcciones)
**Enfoque:** Hybrid (mock data → widgets compartidos → screens)

---

## 1. Arquitectura de Datos Mock

### Repositorios Mock
Crear repositorios mock que implementen las interfaces existentes (a definir) para cada feature:

**`lib/features/catalogo/data/repositories/catalogo_repository_mock.dart`**
- Lista de 8-10 negocios con datos realistas (Piura)
- Cada negocio tiene 6-12 productos organizados en 2-3 secciones de menú
- Categorías: restaurantes, farmacias, mercados, ferreterías
- Datos: nombre, categoría, logo (iniciales con color), rating, tiempo estimado, costo envío, pedido mínimo, dirección, abierto/cerrado

**`lib/features/carrito/data/repositories/carrito_repository_mock.dart`**
- No persistente (estado en memoria via provider)
- Maneja conflicto de negocio (solo un negocio a la vez)

**`lib/features/pedidos/data/repositories/pedidos_repository_mock.dart`**
- 3-5 pedidos de ejemplo en diferentes estados
- Pedidos activos (en camino) y entregados

**`lib/features/pedidos/data/repositories/direcciones_repository_mock.dart`**
- 2 direcciones por defecto (Casa, Trabajo)
- CRUD completo en memoria

### Providers Riverpod
Crear providers para cada repositorio usando el patrón existente:

- `catalogoRepositoryProvider` → Expone lista de negocios y productos
- `carritoControllerProvider` → Notifier con estado del carrito (items, negocio actual)
- `pedidosControllerProvider` → Notifier con lista de pedidos del usuario
- `direccionesControllerProvider` → Notifier con CRUD de direcciones

### Datos Mock (ejemplos)

**Negocios:**
1. Pollería El Picanterón (Restaurante, abierto, 4.5★, ~25min, envío S/3.00, mín S/15)
2. Farmacia San Pablo (Farmacia, abierto, 4.8★, ~30min, envío S/2.50, mín S/10)
3. Mercado Central Piura (Mercado, abierto, 4.3★, ~35min, envío S/4.00, mín S/20)
4. Ferretería Don José (Ferretería, cerrado, 4.2★, ~40min, envío S/5.00, mín S/20)
5. Cevichería La Boca (Restaurante, abierto, 4.6★, ~30min, envío S/3.50, mín S/18)
6. Botica Salud Total (Farmacia, cerrado, 4.4★, ~25min, envío S/2.00, mín S/8)
7. Panadería La Espiga (Mercado, abierto, 4.7★, ~20min, envío S/2.50, mín S/10)
8. Electrohogar (Ferretería, cerrado, 4.0★, ~45min, envío S/6.00, mín S/30)

**Productos (ejemplo Pollería):**
- Pollos a la brasa: 1/4 Pollo + papas + gaseosa (S/18.90), 1/2 Pollo (S/32.90), Pollo entero (S/59.90)
- Complementos: Arroz chaufa (S/12.00), Inca Kola 1.5L (S/8.00), Ensalada (S/7.00)
- Postres: Suspiro limeño (S/6.00), Arroz con leche (S/5.00)

---

## 2. Widgets Compartidos Nuevos

### `NegocioCard`
- Card con avatar (iniciales con gradiente), nombre, badges (abierto/cerrado), rating, tiempo, costo envío
- Tap → navega a `/negocio/:id`
- Cerrados con opacity 0.55
- Ubicación: Home screen

### `ProductoCard`
- Card con nombre, descripción (si existe), precio en rojo, placeholder de imagen
- Ubicación: Detalle de negocio

### `EstadoPedidoTimeline`
- Timeline vertical con 5 estados (pendiente → entregado)
- Dots: completados (verde + check), actual (rojo + glow), pendiente (gris outline)
- Líneas entre dots cambian de color según progreso
- Ubicación: Seguimiento de pedido

### `PedidoResumenCard`
- Card con avatar negocio, nombre, fecha relativa, lista de items, total, badge de estado
- Botón "Repetir pedido" si está entregado
- Tap → navega a `/pedido/:id` (si está activo)
- Ubicación: Historial

### `DireccionCard`
- Card con ícono de casa/trabajo, etiqueta, dirección, referencia
- Acciones: Editar / Eliminar (links azules/rojos)
- Ubicación: Lista de direcciones

### `PaymentMethodSelector`
- Lista de opciones de pago (Yape, Plin, Efectivo)
- Cada opción: ícono con color, nombre, descripción
- Opción seleccionada: borde rojo + fondo rosa claro + check
- Ubicación: Checkout

### `CartItemTile`
- Nombre producto, notas (si existen), precio
- Counter (- cantidad +) con estilos MD3
- Ubicación: Carrito

---

## 3. Screens (8 total)

### 3.1 Home Screen (`/home`)
**Layout:**
- AppBar con título "¿Qué se te antoja hoy?"
- Search bar (funcional: filtra lista)
- Chip scroll horizontal de categorías (Todos, Restaurantes, Farmacias, Mercados, Ferreterías)
- Lista scroll de `NegocioCard` (filtros: búsqueda + categoría)
- Empty state si no hay resultados
- Bottom nav: Explorar activo

**State:**
- `catalogoRepositoryProvider` para lista de negocios
- State local para search query y categoría seleccionada

**Navegación:**
- Tap negocio → `/negocio/:id`

### 3.2 Detalle de Negocio (`/negocio/:id`)
**Layout:**
- AppBar con back arrow + nombre negocio
- Header: badge abierto/cerrado, rating, tiempo, costo envío
- Menú agrupado por secciones (sección label + lista de productos)
- Cada producto: `ProductoCard`

**State:**
- Recibe `id` de path parameter
- `catalogoRepositoryProvider.getProductosByNegocio(id)` para productos
- `catalogoRepositoryProvider.getNegocio(id)` para info

**Navegación:**
- Back → `/home`
- (Futuro: botón agregar al carrito)

### 3.3 Carrito (`/carrito`)
**Layout:**
- AppBar con back + "Tu pedido"
- Sub-header: nombre negocio (con avatar mini)
- Lista de `CartItemTile`
- Resumen: subtotal, envío, total en card
- Botón "Continuar" (disabled si no alcanza mínimo)
- Empty state si carrito vacío

**State:**
- `carritoControllerProvider` para items
- Calcula subtotal, envío, total
- Valida pedido mínimo

**Navegación:**
- Back → negocio anterior
- Continuar → `/checkout`

### 3.4 Checkout (`/checkout`)
**Layout:**
- AppBar con back + "Confirmar pedido"
- Sección dirección: `DireccionCard` seleccionable (borde rojo si seleccionado), tap → picker o navegación
- Sección método de pago: `PaymentMethodSelector`
- Resumen de costos
- Botón "Confirmar pedido" (loading state)

**State:**
- `direccionesControllerProvider` para lista de direcciones
- `carritoControllerProvider` para items del pedido
- State local para dirección seleccionada y método de pago
- Al confirmar: crea pedido via `pedidosControllerProvider`, limpia carrito

**Navegación:**
- Confirmar → `/pedido/:id` (seguimiento del nuevo pedido)
- Back → `/carrito`

### 3.5 Seguimiento de Pedido (`/pedido/:id`)
**Layout:**
- AppBar con back + "Seguimiento"
- Header centrado: ícono de estado, título "¡Ya casi llega!", número pedido
- `EstadoPedidoTimeline` con progreso actual
- Botón "Contactar al negocio" (abre WhatsApp)

**State:**
- Recibe `id` de path parameter
- `pedidosControllerProvider.getPedido(id)` para datos
- (Futuro: polling para actualizar estado)

**Navegación:**
- Back → `/historial`
- Contactar → WhatsApp con mensaje pre-llenado

### 3.6 Historial de Pedidos (`/historial`)
**Layout:**
- AppBar centrada "Mis pedidos"
- Lista de `PedidoResumenCard` ordenada por fecha (más reciente primero)
- Separar pedidos activos (arriba) de entregados (abajo)
- Empty state si no hay pedidos
- Bottom nav: Pedidos activo

**State:**
- `pedidosControllerProvider` para lista de pedidos

**Navegación:**
- Tap pedido activo → `/pedido/:id`
- "Repetir pedido" → agrega items al carrito → `/carrito`

### 3.7 Perfil (`/perfil`)
**Layout:**
- AppBar centrada "Mi perfil"
- Avatar (iniciales con gradiente) + nombre + teléfono
- Lista de opciones: Mis direcciones, Mis datos
- Botón "Cerrar sesión" (rojo, con confirmación)
- Bottom nav: Perfil activo

**State:**
- `sesionControllerProvider` para datos del usuario

**Navegación:**
- Mis direcciones → `/perfil/direcciones`
- Cerrar sesión → `sesionControllerProvider.cerrarSesion()` → redirect a `/login`

### 3.8 Direcciones (`/perfil/direcciones`)
**Layout:**
- AppBar con back + "Mis direcciones"
- Lista de `DireccionCard` con acciones editar/eliminar
- Botón "+ Nueva dirección" (fijo abajo)
- Dialog/bottom sheet para crear/editar: campos etiqueta, dirección, referencia
- Empty state si no hay direcciones

**State:**
- `direccionesControllerProvider` para CRUD

**Navegación:**
- Back → `/perfil`

---

## 4. Mock Data y Repositorios - Detalles

### Interfaz CatalogoRepository
```dart
abstract class CatalogoRepository {
  Future<List<Negocio>> getNegocios();
  Future<Negocio?> getNegocio(String id);
  Future<List<Producto>> getProductosByNegocio(String negocioId);
}
```

### Interfaz PedidosRepository
```dart
abstract class PedidosRepository {
  Future<List<Pedido>> getMisPedidos();
  Future<Pedido?> getPedido(String id);
  Future<Pedido> crearPedido(Pedido pedido);
  Future<void> actualizarEstado(String id, EstadoPedido estado);
}
```

### Interfaz DireccionesRepository
```dart
abstract class DireccionesRepository {
  Future<List<Direccion>> getDirecciones();
  Future<Direccion> crear(Direccion direccion);
  Future<Direccion> actualizar(Direccion direccion);
  Future<void> eliminar(String id);
}
```

---

## 5. Decisiones de Diseño

- **Sin emojis:** Todos los íconos son Material Icons (SVG en mockups, `Icon()` en Flutter)
- **Avatar de negocios:** Iniciales con gradiente de color (no logos reales en MVP)
- **Colores de estado:** Verde (#2E7D32) para abierto/entregado, Rojo (#E63946) para activo/actual, Gris para cerrado/pendiente
- **Moneda:** Siempre via `CurrencyFormatter.formatoPen()` (centavos → "S/ X.XX")
- **Fechas:** Siempre via `DateFormatter.tiempoTranscurrido()` para relativo
- **Bottom nav:** Ya existe en router (ClienteShell), solo falta actualizar íconos a SVG-style
- **Validación:** Usar `Validators` existentes para campos de formulario
- **Loading:** Usar `LigeritoListSkeleton` para listas, `LoadingIndicator` para acciones
- **Error:** Usar `ErrorView` con retry
- **Empty:** Usar `EmptyStateView` con ícono apropiado

---

## 6. Orden de Implementación

1. **Mock data + repos + providers** (catalogo, carrito, pedidos, direcciones)
2. **Widgets compartidos** (NegocioCard, ProductoCard, EstadoPedidoTimeline, PedidoResumenCard, DireccionCard, PaymentMethodSelector, CartItemTile)
3. **Home Screen** (búsqueda, categorías, lista negocios)
4. **Detalle de Negocio** (menú por secciones)
5. **Carrito** (items, resumen, validación mínimo)
6. **Checkout** (dirección, pago, confirmar)
7. **Seguimiento de Pedido** (timeline, contactar)
8. **Historial** (lista pedidos, repetir)
9. **Perfil** (datos usuario, cerrar sesión)
10. **Direcciones** (CRUD completo)
11. **Router update** (reemplazar placeholders con screens reales, actualizar íconos bottom nav)

---

## 7. Fuera de Scope (Fase 2)

- Panel negocio (5 screens)
- Repartidor
- Integración backend real (Dio)
- Firebase / FCM
- Mapas / geolocalización
- Imágenes reales (placeholder por ahora)
- Token persistence (ya existe SecureStorageService pero no está wired)

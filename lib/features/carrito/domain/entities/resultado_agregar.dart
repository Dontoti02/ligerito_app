// lib/features/carrito/domain/entities/resultado_agregar.dart
/// Resultado de intentar agregar un producto al carrito.
/// Enum plano (sin freezed): lo consumen catalogo (UI) y carrito (controller)
/// sin importarse entre sí. Propiedad del orquestador (Fase 0).
enum ResultadoAgregar { agregado, conflictoNegocio }

# Diseño — App Ligerito (Flutter)

**Fecha:** 2026-08-09
**Documento fuente autoritativo:** `PROMPT_MAESTRO_APP_FLUTTER_LIGERITO.md` (raíz del repo). Este spec NO duplica ese documento; registra las decisiones tomadas en la sesión de brainstorming y la estrategia de ejecución. Ante cualquier conflicto, manda el Prompt Maestro.

---

## 1. Alcance

Implementar los **12 módulos del roadmap** (sección 12 del Prompt Maestro) en esta sesión:

| # | Módulo | Tests |
|---|--------|-------|
| 1 | Setup: LigeritoTheme, router, dio_client, api_result, failures | No |
| 2 | Auth completo (entities, usecases, mock+remote repo, screens) | Sí |
| 3 | Home + categorías + búsqueda + paginación | Sí |
| 4 | Detalle negocio + menú agrupado | No |
| 5 | Carrito (controller + UI + validación multi-negocio) | Sí |
| 6 | Checkout + métodos de pago (Yape/Plin/Efectivo) | Sí |
| 7 | Pedido creado + timeline de seguimiento + polling | No |
| 8 | Historial de pedidos + repetir pedido | No |
| 9 | Perfil + gestión de direcciones | No |
| 10 | Panel negocio: pedidos entrantes + aceptar/rechazar | Sí |
| 11 | Panel negocio: CRUD de menú/productos | Sí |
| 12 | Panel negocio: dashboard básico (ventas del día) | No |

Fuera de alcance (Fase 2/3 del Prompt Maestro): tracking GPS en vivo, app repartidor, reseñas, pagos con tarjeta reales, cupones, chat, backend real, web.

## 2. Decisiones del usuario (brainstorming)

1. **Alcance:** los 12 módulos completos en una sesión (no entrega uno-por-uno).
2. **Credenciales externas (Firebase, Google Maps):** abstraer detrás de interfaces con implementación local/mock; la app funciona 100% sin credenciales y queda lista para enchufar keys.
3. **Capa de datos:** `MockRemoteDataSource` para todos los features; `RemoteDataSource` real con Dio **solo en Auth** como patrón de referencia. Swap Mock→Remote = override de 1 línea en el provider.

## 3. Decisiones de ingeniería (delegadas por el Prompt Maestro o menores)

- **Formularios:** manuales con `Form` + `TextFormField` envueltos en `LigeritoTextField`. Los formularios son simples (login 2 campos, registro 4, producto 5, dirección 4); `flutter_form_builder` no se justifica y la regla dura de la sección 2 prohíbe paquetes fuera de la tabla.
- **Push notifications:** interfaz `PushService` en `core/notifications/` + implementación `LocalPushService` con `flutter_local_notifications` (paquete ya aprobado en la tabla). El pedido entrante dispara notificación local + sonido sin Firebase. Para enchufar FCM: agregar `firebase_messaging`, crear `FirebasePushService implements PushService`, override del provider. Sin TODOs en código; el path de migración va documentado en README.
- **Mapas:** `google_maps_flutter` en pubspec (aprobado en la tabla), pero el widget `GoogleMap` solo se renderiza si existe key vía `--dart-define=MAPS_API_KEY=...`. Sin key, el formulario de direcciones usa coordenadas por defecto de Piura centro (lat -5.1945, lng -80.6328) editables por texto. Con key, se activa el picker real sin tocar pantallas.
- **Cache offline:** NO se implementa en MVP (sección 13 del Prompt Maestro: "decidir al llegar a esa fase, no en MVP").
- **Crashlytics:** solo se deja el hook de error handlers en `bootstrap.dart` (zona guardada + `FlutterError.onError`); integración real es Fase 2.

## 4. Arquitectura y stack

Sin cambios respecto al Prompt Maestro:

- Estructura de carpetas **exacta** de la sección 3 (Clean Architecture feature-first, `presentation → domain ← data`; domain nunca importa data ni presentation).
- Stack de la tabla de la sección 2: Riverpod + `riverpod_generator`, `freezed` + `json_serializable`, `go_router` 14+ con guards por rol, `dio` 5+ con `AuthInterceptor` + `ErrorInterceptor`, `flutter_secure_storage` (tokens), `shared_preferences` (flags), `flutter_local_notifications`, `google_maps_flutter` + `geolocator`, `cached_network_image` + `image_picker` + `flutter_image_compress`, `google_fonts` (Poppins/Inter), `mocktail` para tests.
- Entidades de dominio de la sección 4 como `freezed` classes, montos en centavos `int`, formato `S/ X.XX` solo en presentation vía `CurrencyFormatter`.
- Estado: patrón sección 6 (`@riverpod` Notifiers para escritura, `AsyncNotifier`/`FutureProvider` para lectura, estados sealed freezed, `AsyncValue` para loading/error; cero `setState`, cero booleanos sueltos).
- Errores: patrón sección 9 (`ApiResult` sealed, `Failure` hierarchy, `ErrorInterceptor` centralizado, 401 → refresh → logout).
- UI: sistema de diseño sección 7 (`LigeritoColors` exactos, componentes `Ligerito*`, estados loading-skeleton/error/empty/data explícitos, microcopy peruano, contraste AA, `Semantics` en acciones críticas).
- l10n: `flutter gen-l10n` con `l10n/app_es.arb` desde el inicio; cero strings hardcodeados en widgets.
- Manejo de sesión: token en `flutter_secure_storage`, nunca en `shared_preferences`.

## 5. Estrategia de ejecución — Enfoque A (fundación + olas)

**Fase 0 — Fundación (la escribe el orquestador, sin subagentes):**
- `pubspec.yaml` con todas las dependencias, `l10n.yaml`, `analysis_options.yaml`.
- Módulo 1 completo: tema, router base, `DioClient` + interceptores, `ApiResult`/`Failure`, storage services, utils (currency/date/validators), widgets base `Ligerito*`.
- Todas las entidades de dominio compartidas (sección 4) en `features/*/domain/entities` según corresponda.
- `bootstrap.dart`, `app.dart`, `main.dart`.
- Verificación: `flutter pub get`, `build_runner` corre, `flutter analyze` limpio, app arranca.

**Ola 1:** Módulo 2 (Auth) — subagente. Todo lo demás depende de sesión/rol.

**Ola 2 (paralela, tras Auth):**
- Módulo 3 (Home cliente)
- Módulo 9 (Perfil + direcciones)
- Módulo 10 (Panel negocio: pedidos entrantes)

**Ola 3 (paralela, tras Home):**
- Módulo 4 (Detalle negocio + menú)
- Módulo 11 (CRUD menú/productos)
- Módulo 12 (Dashboard ventas del día)

**Ola 4 (secuencial, tras Detalle):**
- Módulo 5 (Carrito) → Módulo 6 (Checkout)

**Ola 5 (secuencial, tras Checkout):**
- Módulo 7 (Seguimiento + polling) → Módulo 8 (Historial + repetir pedido)
- El roadmap marca que 8 depende de 7, y ambos extienden `features/pedidos/`; van en secuencia para no violar la regla de propiedad de carpetas.

**Mapa de features → carpetas (propiedad y orden de escritura):**

| Carpeta | Módulos que la escriben | Orden |
|---|---|---|
| `lib/features/auth/` | 2 | Ola 1 |
| `lib/features/catalogo/` | 3 (crea) → 4 (extiende) | Ola 2 → Ola 3 |
| `lib/features/perfil/` | 9 | Ola 2 |
| `lib/features/panel_negocio/` | 10 (crea) → 11, 12 (extienden) | Ola 2 → Ola 3 |
| `lib/features/carrito/` | 5 | Ola 4 |
| `lib/features/pedidos/` | 6 (crea: checkout + POST) → 7 (tracking) → 8 (historial) | Ola 4 → Ola 5 |

Ninguna carpeta es escrita por dos subagentes en la misma ola. Las entidades de dominio compartidas (`Pedido`, `Negocio`, `Producto`, `ItemCarrito`, `Direccion`, `Usuario`, enums) las crea el orquestador en Fase 0 dentro de la carpeta de su feature natural, para que cualquier ola pueda importarlas sin conflictos.

**Mocks de pedidos:** el mock de `panel_negocio` (pedidos entrantes) y el mock de `pedidos` (cliente) son independientes y pre-sembrados. El mock de cliente sí mantiene en memoria los pedidos creados en checkout durante la sesión, para que aparezcan en seguimiento e historial.

**Reglas para subagentes:**
- Cada subagente escribe SOLO dentro de `lib/features/<su_feature>/` y `test/features/<su_feature>/` según el mapa anterior. Los archivos compartidos (router, tema, pubspec, widgets core, entidades) son propiedad del orquestador.
- Cada feature expone sus rutas como una lista estática (`static List<RouteBase> routes`) que el orquestador registra en `app_router.dart` al cerrar la ola.
- Cada subagente debe cumplir el checklist de la sección 11 del Prompt Maestro y entregar tests cuando el roadmap lo exige.
- El orquestador verifica entre olas: `flutter analyze` sin warnings + `flutter test` verde + rutas registradas.

**Verificación final:** checklist de aceptación de la sección 8 (flujos) revisado por módulo, `flutter analyze` limpio, `flutter test` 100% verde, app compila para Android.

## 6. Riesgos conocidos

- **build_runner/freezed en Windows:** generación lenta; se corre una vez por ola, no por archivo.
- **Conflictos en router:** mitigado porque solo el orquestador registra rutas.
- **Volumen de mock data:** se centraliza en `features/*/data/datasources/mock/` con datos realistas de Piura (nombres, precios en soles, coordenadas).
- **`flutter_local_notifications` en Android moderno:** requiere permiso `POST_NOTIFICATIONS` (API 33+); se declara en `AndroidManifest.xml` y se solicita en runtime al entrar al panel de negocio.

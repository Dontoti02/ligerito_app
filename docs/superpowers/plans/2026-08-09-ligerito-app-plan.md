# Ligerito App — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Construir la app móvil Flutter completa de Ligerito (marketplace de delivery local, Piura — Perú) cubriendo los 12 módulos del roadmap del Prompt Maestro: setup, auth, home, detalle, carrito, checkout, seguimiento, historial, perfil/direcciones y panel de negocio (pedidos, menú, dashboard).

**Architecture:** Clean Architecture feature-first (`presentation → domain ← data`), Riverpod + codegen para estado, go_router con guards por rol, Dio solo en `data/datasources`, mocks pre-sembrados con datos de Piura (Remote real solo en Auth). Push vía interfaz `PushService` con implementación local; mapas con toggle por API key.

**Tech Stack:** Flutter 3.19+ / Dart 3.3+, flutter_riverpod 2.5+ + riverpod_generator, freezed + json_serializable, go_router 14+, dio 5+, flutter_secure_storage, shared_preferences, flutter_local_notifications, google_maps_flutter + geolocator, cached_network_image + image_picker + flutter_image_compress, google_fonts, mocktail.

**Spec de referencia:** `docs/superpowers/specs/2026-08-09-ligerito-app-design.md` y `PROMPT_MAESTRO_APP_FLUTTER_LIGERITO.md` (autoritativo).

**Nota git:** el directorio NO es repo git. Omitir todos los commits salvo que el usuario pida inicializar git.

## Global Constraints

- Estructura de carpetas EXACTA de la sección 3 del Prompt Maestro; cada `.dart` inicia con comentario `// lib/<ruta>` o `// test/<ruta>`.
- Regla de dependencia: `presentation → domain ← data`. Domain NUNCA importa data/presentation. Pantallas solo hablan con providers.
- Cero `setState` para lógica de negocio. Cero `Dio` fuera de `data/datasources`. Cero banderas `isLoading`/`hasError` sueltas (usar `AsyncValue`).
- Montos SIEMPRE en centavos `int` en domain/data; formato `S/ 25.90` SOLO en presentation vía `CurrencyFormatter`.
- Nombres de dominio en español (`Usuario`, `Pedido`, `obtenerNegocios`); infraestructura técnica en inglés (`DioClient`, `AuthInterceptor`).
- Componentes UI compartidos con prefijo `Ligerito*`.
- Cero strings hardcodeados en widgets: usar `AppLocalizations` (gen-l10n, `l10n/app_es.arb`). El orquestador es dueño del `.arb`; los subagentes usan las keys ya definidas (lista en Task 1.8).
- Loading = skeleton (no spinner genérico), error = `ErrorView` con reintentar, empty = `EmptyStateView`, data = contenido.
- Sin `// TODO` ni código incompleto. Cero warnings en `flutter analyze`.
- Tests obligatorios donde el roadmap lo indica (módulos 2, 3, 5, 6, 10, 11 + core utils/widgets).
- Paquetes: SOLO los de la tabla sección 2 del Prompt Maestro (ver Task 1.1 para la lista cerrada).
- `flutter_local_notifications` requiere `POST_NOTIFICATIONS` en `AndroidManifest.xml` y request en runtime al entrar al panel de negocio.
- Convención mock: latencia simulada `Future.delayed(const Duration(milliseconds: 800))`; los mocks retornan ENTIDADES de dominio directamente (sin DTOs); solo el Remote real (Auth) parsea el envelope `{success, data, message, errors}` con DTOs.
- Usuarios mock semilla: cliente `911111111` / negocio `922222222`, password cualquiera de 6+ caracteres. Registro siempre crea rol `cliente`.

---

## File Structure (mapa completo)

```
pubspec.yaml                          # MODIFICAR (deps completas)
l10n.yaml                             # CREAR
analysis_options.yaml                 # MODIFICAR (excludes de generated)
android/app/src/main/AndroidManifest.xml  # MODIFICAR (permisos)
lib/
  main.dart                           # REEMPLAZAR
  bootstrap.dart                      # CREAR
  app.dart                            # CREAR
  core/constants/{api_endpoints, ligerito_colors, app_strings}.dart
  core/theme/{ligerito_theme, text_styles}.dart
  core/router/{app_router, route_guards}.dart
  core/network/{dio_client, api_result}.dart
  core/network/interceptors/{auth_interceptor, error_interceptor}.dart
  core/storage/{secure_storage_service, local_prefs_service}.dart
  core/errors/{failures, exceptions}.dart
  core/utils/{currency_formatter, date_formatter, validators}.dart
  core/notifications/{push_service, local_push_service}.dart
  core/widgets/{ligerito_button, ligerito_text_field, loading_indicator, error_view, empty_state_view}.dart
  features/auth/{data,domain,presentation}/...
  features/catalogo/{data,domain,presentation}/...
  features/carrito/{domain,presentation}/...
  features/pedidos/{data,domain,presentation}/...
  features/perfil/{data,domain,presentation}/...
  features/panel_negocio/{data,domain,presentation}/...
  l10n/app_es.arb
test/
  core/utils/{currency_formatter_test, validators_test, date_formatter_test}.dart
  core/widgets/{ligerito_button_test, ligerito_text_field_test}.dart
  features/auth/domain/usecases/iniciar_sesion_test.dart
  features/catalogo/domain/usecases/obtener_negocios_test.dart
  features/carrito/presentation/providers/carrito_controller_test.dart
  features/pedidos/domain/usecases/crear_pedido_test.dart
  features/pedidos/presentation/widgets/estado_pedido_timeline_test.dart
  features/panel_negocio/domain/usecases/cambiar_estado_pedido_test.dart
  features/panel_negocio/domain/usecases/guardar_producto_test.dart
```

---

## FASE 0 — FUNDACIÓN (la ejecuta el orquestador)

### Task 1.1: Dependencias + configuración base

**Files:**
- Modify: `pubspec.yaml`
- Create: `l10n.yaml`
- Modify: `analysis_options.yaml`
- Modify: `android/app/src/main/AndroidManifest.xml`
- Delete: `test/widget_test.dart` (template counter)

**Interfaces:**
- Produces: toolchain resolviendo con `flutter pub get` sin conflictos.

- [ ] **Step 1: Reescribir `pubspec.yaml`**

```yaml
name: ligerito
description: "Ligerito — Tu pedido, al toque. Marketplace de delivery local."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.12.2

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.8
  # Estado
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1
  # Modelos
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  # Navegación
  go_router: ^14.8.1
  # HTTP
  dio: ^5.7.0
  # Storage
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.2
  # Notificaciones
  flutter_local_notifications: ^17.2.4
  # Mapas
  google_maps_flutter: ^2.10.0
  geolocator: ^13.0.1
  # Imágenes
  cached_network_image: ^3.4.1
  image_picker: ^1.1.2
  flutter_image_compress: ^2.3.0
  # Tipografía
  google_fonts: ^6.2.1
  # i18n / formato
  intl: ^0.20.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.3
  freezed: ^2.5.7
  json_serializable: ^6.9.0
  mocktail: ^1.0.4

flutter:
  uses-material-design: true
  generate: true
```

- [ ] **Step 2: Crear `l10n.yaml`**

```yaml
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
synthetic-package: false
```

- [ ] **Step 3: Reescribir `analysis_options.yaml`**

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "lib/l10n/**/*.dart"
```

- [ ] **Step 4: Agregar permisos en `android/app/src/main/AndroidManifest.xml`** (dentro de `<manifest>`, antes de `<application>`)

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

Y dentro de `<application>` agregar el meta-data de Maps (se activa con key real; sin key el widget `GoogleMap` nunca se renderiza):

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="${mapsApiKey}"/>
```

En `android/app/build.gradle.kts`, dentro de `android { defaultConfig { ... } }` agregar:

```kotlin
manifestPlaceholders["mapsApiKey"] = System.getenv("MAPS_API_KEY") ?: "SIN_KEY"
```

- [ ] **Step 5: Eliminar `test/widget_test.dart` del template y limpiar `lib/main.dart`** (se reescribe en Task 1.9).

- [ ] **Step 6: Verificar**

Run: `flutter pub get`
Expected: `Got dependencies!` sin conflictos de versiones. Si alguna versión no resuelve con Dart 3.12, subir el constraint a la versión compatible más cercana (nunca bajar el SDK).

---

### Task 1.2: Constantes, tema y errores (branding + failures)

**Files:**
- Create: `lib/core/constants/ligerito_colors.dart`
- Create: `lib/core/constants/api_endpoints.dart`
- Create: `lib/core/constants/app_strings.dart`
- Create: `lib/core/theme/text_styles.dart`
- Create: `lib/core/theme/ligerito_theme.dart`
- Create: `lib/core/errors/failures.dart`
- Create: `lib/core/errors/exceptions.dart`

**Interfaces:**
- Produces: `LigeritoColors` (estáticos), `LigeritoTheme.light` (ThemeData), `LigeritoTextStyles`, `ApiEndpoints` (baseUrl + paths), jerarquía `Failure`, excepciones `ServerException`/`NetworkException`/`UnauthorizedException`.

- [ ] **Step 1: `ligerito_colors.dart`** — colores EXACTOS de la sección 7 del Prompt Maestro:

```dart
// lib/core/constants/ligerito_colors.dart
import 'package:flutter/material.dart';

class LigeritoColors {
  LigeritoColors._();

  static const primary = Color(0xFFE63946);
  static const primaryDark = Color(0xFFC1121F);
  static const secondary = Color(0xFF2E7D32);
  static const background = Color(0xFFFAFAFA);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const error = Color(0xFFD32F2F);
  static const warning = Color(0xFFF9A825);
  static const info = Color(0xFF1976D2);
}
```

- [ ] **Step 2: `api_endpoints.dart`**

```dart
// lib/core/constants/api_endpoints.dart
class ApiEndpoints {
  ApiEndpoints._();

  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.ligerito.pe',
  );

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refresh = '/auth/refresh';
  static const negocios = '/negocios';
  static String negocioDetalle(String id) => '/negocios/$id';
  static const pedidos = '/pedidos';
  static String pedidoDetalle(String id) => '/pedidos/$id';
  static String pedidoEstado(String id) => '/pedidos/$id/estado';
  static const pedidosEntrantes = '/negocio/pedidos-entrantes';
  static const productos = '/negocio/productos';
}
```

- [ ] **Step 3: `app_strings.dart`** (solo fallback técnico; strings de UI van en el `.arb`)

```dart
// lib/core/constants/app_strings.dart
class AppStrings {
  AppStrings._();

  static const appName = 'Ligerito';
  static const tagline = 'Tu pedido, al toque.';
  static const keyTokenSesion = 'ligerito_access_token';
  static const keyRefreshToken = 'ligerito_refresh_token';
  static const keyOnboardingVisto = 'ligerito_onboarding_visto';
}
```

- [ ] **Step 4: `text_styles.dart` + `ligerito_theme.dart`** — Poppins títulos / Inter cuerpo vía `google_fonts`, ColorScheme desde `LigeritoColors.primary`, scaffold background `LigeritoColors.background`, cuerpo mínimo 14sp:

```dart
// lib/core/theme/text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';

class LigeritoTextStyles {
  LigeritoTextStyles._();

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 24, fontWeight: FontWeight.w700, color: LigeritoColors.textPrimary);
  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 20, fontWeight: FontWeight.w600, color: LigeritoColors.textPrimary);
  static TextStyle get body => GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: LigeritoColors.textPrimary);
  static TextStyle get bodySecondary => GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: LigeritoColors.textSecondary);
  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w700, color: LigeritoColors.primary);
}
```

```dart
// lib/core/theme/ligerito_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';

class LigeritoTheme {
  LigeritoTheme._();

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: LigeritoColors.primary,
      primary: LigeritoColors.primary,
      secondary: LigeritoColors.secondary,
      surface: LigeritoColors.surface,
      error: LigeritoColors.error,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: LigeritoColors.background,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: LigeritoColors.textPrimary),
        headlineMedium: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: LigeritoColors.textPrimary),
        bodyMedium: GoogleFonts.inter(fontSize: 14, color: LigeritoColors.textPrimary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: LigeritoColors.surface,
        foregroundColor: LigeritoColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: LigeritoColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LigeritoColors.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: LigeritoColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: LigeritoColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
```

- [ ] **Step 5: `failures.dart` + `exceptions.dart`** — jerarquía EXACTA de la sección 9 del Prompt Maestro:

```dart
// lib/core/errors/failures.dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Sin conexión a internet');
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>> errors;
  const ValidationFailure(this.errors) : super('Error de validación');
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Sesión expirada');
}
```

```dart
// lib/core/errors/exceptions.dart
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
}

class NetworkException implements Exception {
  const NetworkException();
}

class UnauthorizedException implements Exception {
  const UnauthorizedException();
}

class ValidationException implements Exception {
  final Map<String, List<String>> errors;
  const ValidationException(this.errors);
}
```

- [ ] **Step 6: Verificar** — `flutter analyze lib/core` sin errores (warnings de imports sin usar aún se resuelven al completar Fase 0).

---

### Task 1.3: Red — ApiResult, DioClient, interceptores

**Files:**
- Create: `lib/core/network/api_result.dart`
- Create: `lib/core/network/dio_client.dart`
- Create: `lib/core/network/interceptors/auth_interceptor.dart`
- Create: `lib/core/network/interceptors/error_interceptor.dart`
- Create: `lib/core/storage/secure_storage_service.dart`
- Create: `lib/core/storage/local_prefs_service.dart`

**Interfaces:**
- Consumes: `failures.dart`, `api_endpoints.dart`, `app_strings.dart`.
- Produces:
  - `sealed class ApiResult<T>` con `ApiSuccess<T>(T data)` y `ApiError<T>(Failure failure)` (nombres EXACTOS de sección 9).
  - `class SecureStorageService { Future<String?> leerToken(); Future<void> guardarTokens({required String accessToken, required String refreshToken}); Future<void> limpiar(); }`
  - `class LocalPrefsService { Future<bool> get onboardingVisto; Future<void> marcarOnboardingVisto(); }`
  - `Dio buildDioClient(SecureStorageService storage, {required Future<void> Function() onSesionExpirada})` — Dio con `BaseOptions(baseUrl: ApiEndpoints.baseUrl, connectTimeout: 10s, receiveTimeout: 15s)` + `AuthInterceptor` + `ErrorInterceptor`.

- [ ] **Step 1: `api_result.dart`**

```dart
// lib/core/network/api_result.dart
import 'package:ligerito/core/errors/failures.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final Failure failure;
  const ApiError(this.failure);
}
```

- [ ] **Step 2: `secure_storage_service.dart`** — token SOLO en secure storage (criterio sección 8.1):

```dart
// lib/core/storage/secure_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ligerito/core/constants/app_strings.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;
  SecureStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  Future<String?> leerToken() => _storage.read(key: AppStrings.keyTokenSesion);

  Future<String?> leerRefreshToken() => _storage.read(key: AppStrings.keyRefreshToken);

  Future<void> guardarTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: AppStrings.keyTokenSesion, value: accessToken);
    await _storage.write(key: AppStrings.keyRefreshToken, value: refreshToken);
  }

  Future<void> limpiar() => _storage.deleteAll();
}
```

- [ ] **Step 3: `local_prefs_service.dart`** — solo flags simples, NUNCA tokens:

```dart
// lib/core/storage/local_prefs_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ligerito/core/constants/app_strings.dart';

class LocalPrefsService {
  Future<bool> get onboardingVisto async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppStrings.keyOnboardingVisto) ?? false;
  }

  Future<void> marcarOnboardingVisto() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.keyOnboardingVisto, true);
  }
}
```

- [ ] **Step 4: `auth_interceptor.dart`**

```dart
// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:ligerito/core/storage/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;
  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.leerToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
```

- [ ] **Step 5: `error_interceptor.dart`**

```dart
// lib/core/network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:ligerito/core/errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  final Future<void> Function() onSesionExpirada;
  ErrorInterceptor({required this.onSesionExpirada});

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return handler.reject(DioException(
          requestOptions: err.requestOptions, error: const NetworkException()));
    }
    if (status == 401) {
      await onSesionExpirada();
      return handler.reject(DioException(
          requestOptions: err.requestOptions, error: const UnauthorizedException()));
    }
    if (status == 422) {
      final errors = (err.response?.data?['errors'] as Map?)?.map(
              (k, v) => MapEntry(k.toString(), List<String>.from(v as List))) ??
          <String, List<String>>{};
      return handler.reject(DioException(
          requestOptions: err.requestOptions, error: ValidationException(errors)));
    }
    final message = err.response?.data?['message']?.toString() ?? 'Error del servidor';
    handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ServerException(message, statusCode: status)));
  }
}
```

- [ ] **Step 6: `dio_client.dart`**

```dart
// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:ligerito/core/constants/api_endpoints.dart';
import 'package:ligerito/core/network/interceptors/auth_interceptor.dart';
import 'package:ligerito/core/network/interceptors/error_interceptor.dart';
import 'package:ligerito/core/storage/secure_storage_service.dart';

Dio buildDioClient(
  SecureStorageService storage, {
  required Future<void> Function() onSesionExpirada,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  dio.interceptors.addAll([
    AuthInterceptor(storage),
    ErrorInterceptor(onSesionExpirada: onSesionExpirada),
  ]);
  return dio;
}
```

- [ ] **Step 7: Verificar** — `flutter analyze lib/core` limpio.

---

### Task 1.4: Utils (formatters + validators) CON TESTS

**Files:**
- Create: `lib/core/utils/currency_formatter.dart`
- Create: `lib/core/utils/date_formatter.dart`
- Create: `lib/core/utils/validators.dart`
- Test: `test/core/utils/currency_formatter_test.dart`
- Test: `test/core/utils/validators_test.dart`
- Test: `test/core/utils/date_formatter_test.dart`

**Interfaces:**
- Produces:
  - `class CurrencyFormatter { static String formatoPen(int centavos); }` → `"S/ 25.90"`, `"S/ 1,250.00"`, `"S/ 0.00"`.
  - `class LigeritoValidators { static String? telefono(String? v); static String? password(String? v); static String? nombreObligatorio(String? v); static String? precioPositivo(String? v); }` — retornan `null` si válido, mensaje en español si no.
  - `class DateFormatter { static String fechaHora(DateTime dt); static String tiempoTranscurrido(DateTime desde, {DateTime? ahora}); }` — `"hace 5 min"`, `"hace 1 h"`, `"ayer"`.

- [ ] **Step 1: Escribir tests fallidos** (`currency_formatter_test.dart`):

```dart
// test/core/utils/currency_formatter_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';

void main() {
  group('CurrencyFormatter.formatoPen', () {
    test('formatea centavos a soles con punto decimal', () {
      expect(CurrencyFormatter.formatoPen(2590), 'S/ 25.90');
    });
    test('cero', () {
      expect(CurrencyFormatter.formatoPen(0), 'S/ 0.00');
    });
    test('miles con separador de coma', () {
      expect(CurrencyFormatter.formatoPen(125000), 'S/ 1,250.00');
    });
    test('redondea centavos exactos sin decimales de más', () {
      expect(CurrencyFormatter.formatoPen(1000), 'S/ 10.00');
    });
  });
}
```

```dart
// test/core/utils/validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/utils/validators.dart';

void main() {
  group('LigeritoValidators.telefono', () {
    test('rechaza vacío', () => expect(LigeritoValidators.telefono(''), isNotNull));
    test('rechaza 8 dígitos', () => expect(LigeritoValidators.telefono('98765432'), isNotNull));
    test('rechaza si no empieza con 9', () => expect(LigeritoValidators.telefono('187654321'), isNotNull));
    test('acepta 9 dígitos empezando con 9', () => expect(LigeritoValidators.telefono('987654321'), isNull));
  });

  group('LigeritoValidators.password', () {
    test('rechaza menos de 6 caracteres', () => expect(LigeritoValidators.password('12345'), isNotNull));
    test('acepta 6+ caracteres', () => expect(LigeritoValidators.password('123456'), isNull));
  });

  group('LigeritoValidators.precioPositivo', () {
    test('rechaza 0', () => expect(LigeritoValidators.precioPositivo('0'), isNotNull));
    test('rechaza negativo', () => expect(LigeritoValidators.precioPositivo('-5'), isNotNull));
    test('rechaza texto', () => expect(LigeritoValidators.precioPositivo('abc'), isNotNull));
    test('acepta decimal positivo', () => expect(LigeritoValidators.precioPositivo('12.50'), isNull));
  });

  group('LigeritoValidators.nombreObligatorio', () {
    test('rechaza vacío', () => expect(LigeritoValidators.nombreObligatorio('  '), isNotNull));
    test('acepta nombre', () => expect(LigeritoValidators.nombreObligatorio('Juan'), isNull));
  });
}
```

- [ ] **Step 2: Correr tests — deben FALLAR** (`Target of URI doesn't exist`).

- [ ] **Step 3: Implementar**

```dart
// lib/core/utils/currency_formatter.dart
import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _format = NumberFormat('#,##0.00', 'en_US');

  /// Convierte centavos (int) a "S/ 25.90". ÚNICO lugar donde se formatea dinero.
  static String formatoPen(int centavos) => 'S/ ${_format.format(centavos / 100)}';
}
```

```dart
// lib/core/utils/validators.dart
class LigeritoValidators {
  LigeritoValidators._();

  static String? telefono(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresa tu teléfono';
    if (!RegExp(r'^9\d{8}$').hasMatch(v)) {
      return 'Teléfono inválido: 9 dígitos y empieza con 9';
    }
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? nombreObligatorio(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Este campo es obligatorio';
    return null;
  }

  static String? precioPositivo(String? value) {
    final parsed = double.tryParse(value ?? '');
    if (parsed == null) return 'Ingresa un precio válido';
    if (parsed <= 0) return 'El precio debe ser mayor a 0';
    return null;
  }
}
```

```dart
// lib/core/utils/date_formatter.dart
import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String fechaHora(DateTime dt) => DateFormat('dd/MM/yyyy hh:mm a', 'es_PE').format(dt);

  static String tiempoTranscurrido(DateTime desde, {DateTime? ahora}) {
    final diff = (ahora ?? DateTime.now()).difference(desde);
    if (diff.inMinutes < 1) return 'ahora mismo';
    if (diff.inMinutes < 60) return 'hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'hace ${diff.inHours} h';
    if (diff.inDays == 1) return 'ayer';
    return 'hace ${diff.inDays} días';
  }
}
```

- [ ] **Step 4: `date_formatter_test.dart`** — casos: 30s → "ahora mismo"; 5min → "hace 5 min"; 3h → "hace 3 h"; 1d → "ayer"; 4d → "hace 4 días" (usando `ahora` fijo inyectado).

- [ ] **Step 5: Verificar** — `flutter test test/core/utils` verde.

---

### Task 1.5: Widgets base Ligerito* CON WIDGET TESTS

**Files:**
- Create: `lib/core/widgets/ligerito_button.dart`
- Create: `lib/core/widgets/ligerito_text_field.dart`
- Create: `lib/core/widgets/loading_indicator.dart` (skeletons, NO spinner genérico)
- Create: `lib/core/widgets/error_view.dart`
- Create: `lib/core/widgets/empty_state_view.dart`
- Test: `test/core/widgets/ligerito_button_test.dart`
- Test: `test/core/widgets/ligerito_text_field_test.dart`

**Interfaces:**
- Produces (firmas EXACTAS que usarán todas las features):
  - `LigeritoButton({required String label, VoidCallback? onPressed, bool loading = false, LigeritoButtonVariant variant = LigeritoButtonVariant.primary})` — enum `LigeritoButtonVariant { primary, secondary, outline }`. Si `loading=true` muestra `CircularProgressIndicator` interno y deshabilita el tap. `Semantics(button: true, label: label)`.
  - `LigeritoTextField({required String label, String? hint, TextEditingController? controller, String? Function(String?)? validator, TextInputType keyboardType, bool obscureText = false, int maxLines = 1})` — validación inline via `FormFieldValidator`.
  - `ErrorView({required String message, required VoidCallback onRetry})` — ícono error, mensaje, `LigeritoButton` "Reintentar".
  - `EmptyStateView({required IconData icon, required String title, String? subtitle})`.
  - `SkeletonBox({double width = double.infinity, double height = 16, double radius = 8})` + `LigeritoListSkeleton({int itemCount = 5, double itemHeight = 88})` — containers grises con `AnimatedOpacity` pulse.

- [ ] **Step 1: Widget test `ligerito_button_test.dart`**

```dart
// test/core/widgets/ligerito_button_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('muestra el label y dispara onPressed', (tester) async {
    var taps = 0;
    await tester.pumpWidget(wrap(LigeritoButton(label: 'Confirmar', onPressed: () => taps++)));
    expect(find.text('Confirmar'), findsOneWidget);
    await tester.tap(find.byType(LigeritoButton));
    expect(taps, 1);
  });

  testWidgets('en loading no dispara onPressed y muestra indicador', (tester) async {
    var taps = 0;
    await tester.pumpWidget(wrap(LigeritoButton(label: 'Confirmar', loading: true, onPressed: () => taps++)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(LigeritoButton));
    expect(taps, 0);
  });

  testWidgets('deshabilitado cuando onPressed es null', (tester) async {
    await tester.pumpWidget(wrap(const LigeritoButton(label: 'X', onPressed: null)));
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });
}
```

- [ ] **Step 2: Implementar `ligerito_button.dart`** — variantes: primary → `ElevatedButton` (tema), secondary → fondo `LigeritoColors.secondary`, outline → `OutlinedButton` con borde primary y texto primary. Loading reemplaza el child por `SizedBox(20×20, CircularProgressIndicator(strokeWidth: 2, color: onPrimary))` y anula onPressed.

- [ ] **Step 3: Widget test `ligerito_text_field_test.dart`** — renderiza label; muestra mensaje de error cuando validator retorna string tras `form.validate()`; obscureText activo cuando `obscureText: true`.

- [ ] **Step 4: Implementar `ligerito_text_field.dart`** — `TextFormField` con `autovalidateMode: AutovalidateMode.onUserInteraction`, decoración del tema.

- [ ] **Step 5: Implementar `error_view.dart`, `empty_state_view.dart`, `loading_indicator.dart`** (skeletons con pulse animation via `AnimationController` + `useState`-free: usar `StatefulWidget` local trivial — permitido por checklist "solo animaciones/UI trivial local").

- [ ] **Step 6: Verificar** — `flutter test test/core/widgets` verde + `flutter analyze lib/core` limpio.

---

### Task 1.6: Entidades de dominio compartidas (freezed)

**Files (todas CREAR):**
- `lib/features/auth/domain/entities/usuario.dart`
- `lib/features/catalogo/domain/entities/negocio.dart`
- `lib/features/catalogo/domain/entities/producto.dart`
- `lib/features/carrito/domain/entities/item_carrito.dart`
- `lib/features/pedidos/domain/entities/pedido.dart`
- `lib/features/pedidos/domain/entities/direccion.dart`
- `lib/features/pedidos/domain/entities/estado_pedido.dart`
- `lib/features/pedidos/domain/entities/metodo_pago.dart`
- `lib/features/carrito/domain/entities/resultado_agregar.dart`

**Interfaces:**
- Produces (firmas EXACTAS de la sección 4 del Prompt Maestro, como freezed):
  - `Usuario({String id, String nombre, String telefono, String? email, RolUsuario rol, String? fotoUrl})` + `enum RolUsuario { cliente, negocio, repartidor }`
  - `Negocio({String id, String nombre, String categoria, String logoUrl, double calificacion, bool abierto, int tiempoEstimadoMin, double costoEnvioBase, double pedidoMinimo, Direccion direccion})`
  - `Producto({String id, String negocioId, String nombre, String? descripcion, int precioEnCentavos, String? imagenUrl, bool disponible, String? seccionMenu})`
  - `ItemCarrito({Producto producto, int cantidad, String? notas})` con getter `int get subtotalEnCentavos => producto.precioEnCentavos * cantidad;` (private constructor `const ItemCarrito._();`)
  - `Pedido({String id, String negocioId, List<ItemCarrito> items, EstadoPedido estado, MetodoPago metodoPago, int subtotalEnCentavos, int costoEnvioEnCentavos, int totalEnCentavos, Direccion direccionEntrega, DateTime creadoEn, String? clienteNombre, String? clienteTelefono})` — los dos últimos campos extra necesarios para el card de pedido entrante (sección 8.5: "muestra cliente").
  - `Direccion({String id, String etiqueta, String direccionTexto, double lat, double lng, String? referencia})`
  - `enum EstadoPedido { pendiente, confirmado, preparando, enCamino, entregado, cancelado }`
  - `enum MetodoPago { yape, plin, efectivo, tarjeta }`
  - `enum ResultadoAgregar { agregado, conflictoNegocio }` (enum plano, sin freezed — archivo propiedad del orquestador; lo consumen catalogo UI y carrito controller sin importarse entre sí)

Nota: `Negocio.costoEnvioBase` y `pedidoMinimo` se mantienen `double` en soles EXACTAMENTE como la sección 4 (son configuración, no montos de transacción; la conversión a centavos para cálculos de pedido ocurre en checkout: `(costoEnvioBase * 100).round()`).

- [ ] **Step 1: Escribir las 8 entidades con `@freezed`** (sin `fromJson` — las entidades son puras; los mocks las construyen directamente).

- [ ] **Step 2: Correr codegen**

Run: `dart run build_runner build --delete-conflicting-outputs`
Expected: genera `*.freezed.dart` sin errores.

- [ ] **Step 3: Verificar** — `flutter analyze lib/features` limpio.

---

### Task 1.7: PushService (interfaz + local)

**Files:**
- Create: `lib/core/notifications/push_service.dart`
- Create: `lib/core/notifications/local_push_service.dart`

**Interfaces:**
- Produces:
  - `abstract class PushService { Future<void> inicializar(); Future<void> mostrarNotificacionPedido({required String titulo, required String cuerpo}); Future<bool> solicitarPermiso(); }`
  - `class LocalPushService implements PushService` — usa `FlutterLocalNotificationsPlugin`; canal Android `ligerito_pedidos` (importancia max, sonido default del sistema, vibración). `inicializar()` configura `InitializationSettings` (icono `@mipmap/ic_launcher`). `solicitarPermiso()` pide `POST_NOTIFICATIONS` en Android 13+ via `resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission()`.

- [ ] **Step 1: Implementar interfaz + LocalPushService completo.**

- [ ] **Step 2: Verificar** — `flutter analyze lib/core/notifications` limpio. (Test de integración real de notificaciones queda fuera de unit tests; se valida en Ola 2 al conectar el panel.)

---

### Task 1.8: l10n — app_es.arb con TODAS las keys

**Files:**
- Create: `lib/l10n/app_es.arb`

**Interfaces:**
- Produces: `AppLocalizations` con todas las keys que consumen los 12 módulos. Convención: `<pantalla>_<elemento>` camelCase. Subagentes SOLO usan estas keys (si falta alguna, la piden al orquestador, no editan el `.arb`).

- [ ] **Step 1: Escribir `app_es.arb`** con estos grupos de keys (microcopy peruano de la sección 7):

```
appName=Ligerito, tagline="Tu pedido, al toque."
login_titulo="¡Qué bueno verte!", login_subtitulo="Ingresa para pedir tu favorito",
login_telefono="Teléfono", login_password="Contraseña", login_boton="Ingresar",
login_sinCuenta="¿No tienes cuenta? Regístrate", login_olvidaste="¿Olvidaste tu contraseña?",
login_errorCredenciales="Teléfono o contraseña incorrectos",
registro_titulo="Crea tu cuenta", registro_nombre="Nombre completo",
registro_email="Correo (opcional)", registro_boton="Registrarme",
registro_exito="¡Listo! Ya eres parte de Ligerito",
recuperar_titulo="Recuperar contraseña", recuperar_boton="Enviar enlace",
recuperar_mensaje="Te enviaremos instrucciones a tu correo o SMS",
home_titulo="¿Qué se te antoja hoy?", home_buscarHint="Busca pollerías, farmacias...",
home_vacioTitulo="Ningún negocio cerca abierto por ahora",
home_vacioSubtitulo="Intenta con otra categoría o vuelve pronto",
categoria_todos="Todos", categoria_restaurante="Restaurantes", categoria_farmacia="Farmacias",
categoria_mercado="Mercados", categoria_ferreteria="Ferreterías",
negocio_abierto="Abierto", negocio_cerrado="Cerrado",
negocio_tiempo="~{min} min", negocio_envio="Envío {costo}", negocio_pedidoMinimo="Mínimo {monto}",
detalle_agregar="Agregar", detalle_notasHint="Notas (ej. sin cebolla)",
carrito_titulo="Tu pedido", carrito_vacio="Tu carrito está vacío",
carrito_vacioSubtitulo="Agrega algo rico de un negocio",
carrito_conflictoTitulo="¿Cambiar de negocio?",
carrito_conflictoMensaje="Tu carrito tiene productos de {negocio}. Solo puedes pedir de un negocio a la vez.",
carrito_conflictoConfirmar="Vaciar y agregar", carrito_continuar="Continuar",
carrito_minimoNoAlcanzado="Te falta {monto} para el pedido mínimo",
carrito_subtotal="Subtotal", carrito_envio="Costo de envío", carrito_total="Total",
checkout_titulo="Confirmar pedido", checkout_direccion="Dirección de entrega",
checkout_metodoPago="Método de pago", checkout_yapeInstruccion="Yapea al {numero} y adjunta tu captura",
checkout_plinInstruccion="Haz Plin al {numero} y adjunta tu captura",
checkout_adjuntarCaptura="Adjuntar captura (opcional)",
checkout_confirmar="Confirmar pedido", checkout_efectivoNota="Paga en efectivo al recibir",
pedido_confirmadoTitulo="¡Pedido confirmado!",
pedido_confirmadoMensaje="Tu pedido #{numero} ya está con el negocio",
pedido_verSeguimiento="Ver seguimiento",
seguimiento_titulo="Seguimiento", seguimiento_casiLlega="¡Ya casi llega, ligerito!",
seguimiento_contactar="Contactar al negocio",
estado_pendiente="Pendiente", estado_confirmado="Confirmado", estado_preparando="Preparando",
estado_enCamino="En camino", estado_entregado="Entregado", estado_cancelado="Cancelado",
historial_titulo="Mis pedidos", historial_vacio="Aún no tienes pedidos",
historial_vacioSubtitulo="Tu primer pedido te espera, ligerito",
historial_repetir="Repetir pedido",
perfil_titulo="Mi perfil", perfil_cerrarSesion="Cerrar sesión",
perfil_direcciones="Mis direcciones", direccion_etiqueta="Etiqueta (Casa, Trabajo)",
direccion_texto="Dirección", direccion_referencia="Referencia (opcional)",
direccion_guardar="Guardar dirección", direccion_eliminar="Eliminar",
panel_pedidosTitulo="Pedidos entrantes", panel_aceptar="Aceptar", panel_rechazar="Rechazar",
panel_confirmarAccion="¿Seguro?", panel_tiempoEstimado="Tiempo estimado",
panel_menuTitulo="Mi menú", panel_nuevoProducto="Nuevo producto",
panel_productoNombre="Nombre del producto", panel_productoPrecio="Precio (S/)",
panel_productoSeccion="Sección del menú", panel_productoDisponible="Disponible",
panel_guardar="Guardar", panel_eliminar="Eliminar producto",
panel_dashboardTitulo="Ventas de hoy", panel_ventasTotal="Vendido hoy",
panel_pedidosCount="Pedidos", panel_ticketPromedio="Ticket promedio",
error_generico="Algo salió mal. Intenta de nuevo",
error_sinConexion="Sin conexión a internet", error_reintentar="Reintentar",
comun_aceptar="Aceptar", comun_cancelar="Cancelar", comun_si="Sí", comun_no="No"
```

(con placeholders declarados en sintaxis arb: `"negocio_tiempo": "~{min} min", "@negocio_tiempo": {"placeholders": {"min": {"type": "int"}}}`, etc.)

- [ ] **Step 2: Generar localizations**

Run: `flutter gen-l10n`
Expected: genera `lib/l10n/app_localizations.dart` (+ `app_localizations_es.dart`) sin errores.

---

### Task 1.9: App shell — main, bootstrap, app, router + guards

**Files:**
- Create: `lib/bootstrap.dart`
- Create: `lib/app.dart`
- Modify: `lib/main.dart`
- Create: `lib/core/router/app_router.dart`
- Create: `lib/core/router/route_guards.dart`

**Interfaces:**
- Consumes: `lib/features/auth/presentation/providers/sesion_controller.dart` que el orquestador crea en ESTA task como stub compilable y Ola 1 extiende in-place (mismo archivo, mismo provider name — el router nunca cambia de import).
- Produces:
  - `lib/features/auth/presentation/providers/sesion_controller.dart` (stub Fase 0): `@freezed sealed class SesionState` con `cargando() | autenticado(Usuario usuario) | noAutenticado()`; `@riverpod class SesionController extends _$SesionController { Future<SesionState> build() async => const SesionState.noAutenticado(); }` (Ola 1 cambia el body para resolver `ObtenerSesionActual` y agrega `iniciarSesion/registrar/cerrarSesion`).
  - `class RouterRefreshNotifier extends ChangeNotifier` en `app_router.dart`: el orquestador lo suscribe a cambios de `sesionControllerProvider` (`ref.listen` en el provider del router) para refrescar redirects.
  - `Future<void> bootstrap() async` — `WidgetsFlutterBinding.ensureInitialized()`, `initializeDateFormatting('es_PE')`, `FlutterError.onError` hook (punto de enchufe Crashlytics Fase 2), corre `runApp` dentro de `runZonedGuarded`.
  - `class LigeritoApp extends ConsumerWidget` → `MaterialApp.router(title: 'Ligerito', theme: LigeritoTheme.light, routerConfig: router, localizationsDelegates: AppLocalizations.localizationsDelegates, supportedLocales: AppLocalizations.supportedLocales, locale: Locale('es','PE'))`.
  - `GoRouter appRouter(AppRouterRef ref)` con rutas: `/splash`, `/login`, `/registro`, `/recuperar`; shell cliente `StatefulShellRoute.indexedStack` con tabs Explorar `/home`, Pedidos `/historial`, Perfil `/perfil`; rutas sueltas `/negocio/:id`, `/carrito`, `/checkout`, `/pedido/:id`, `/perfil/direcciones`; shell negocio con tabs `/panel/pedidos`, `/panel/menu`, `/panel/dashboard`; `/panel/producto/nuevo`, `/panel/producto/:id/editar`.
  - `String? routeGuard(SesionState sesion, String location)` — lógica: sin sesión → `/login` salvo rutas públicas (`/login`, `/registro`, `/recuperar`); rol cliente en `/panel/*` → `/home`; rol negocio fuera de `/panel/*` (y no pública) → `/panel/pedidos`; `/splash` → decide por sesión.
  - En Fase 0, las pantallas destino de cada ruta son `PlaceholderScreen(nombre)` temporal que cada ola reemplaza al registrarse. El router es propiedad del orquestador: cada ola entrega `static List<RouteBase> routes` por feature y el orquestador las enchufa.

- [ ] **Step 1: Implementar `route_guards.dart`** con la lógica pura `routeGuard` (testeable, sin BuildContext).

- [ ] **Step 2: Implementar `app_router.dart`** con la estructura de rutas completa y `PlaceholderScreen`.

- [ ] **Step 3: Implementar `bootstrap.dart`, `app.dart`, `main.dart`:**

```dart
// lib/main.dart
import 'package:ligerito/bootstrap.dart';

Future<void> main() => bootstrap();
```

- [ ] **Step 4: Verificar** — `flutter analyze lib` limpio + `flutter test` verde + `flutter build apk --debug` compila (o `flutter run` en emulador si está disponible; mínimo `flutter analyze` + build web no aplica, usar `flutter build apk --debug`).

---

## OLA 1 — AUTH (Módulo 2, roadmap)

### Task 2.1: Auth domain (contratos + usecases) CON TEST

**Files:**
- Create: `lib/features/auth/domain/repositories/auth_repository.dart`
- Create: `lib/features/auth/domain/usecases/iniciar_sesion.dart`
- Create: `lib/features/auth/domain/usecases/registrar_usuario.dart`
- Create: `lib/features/auth/domain/usecases/cerrar_sesion.dart`
- Create: `lib/features/auth/domain/usecases/obtener_sesion_actual.dart`
- Test: `test/features/auth/domain/usecases/iniciar_sesion_test.dart`

**Interfaces:**
- Consumes: `Usuario`, `ApiResult`, `Failure`.
- Produces:
  - `abstract class AuthRepository { Future<ApiResult<Usuario>> login({required String telefono, required String password}); Future<ApiResult<Usuario>> register({required String nombre, required String telefono, required String password, String? email}); Future<ApiResult<Usuario?>> sesionActual(); Future<void> logout(); Future<ApiResult<void>> recuperarPassword({required String telefono}); }`
  - Usecases con `call()` que delegan 1:1: `class IniciarSesion { IniciarSesion(this._repo); Future<ApiResult<Usuario>> call({required String telefono, required String password}); }` (ídem `RegistrarUsuario`, `CerrarSesion`, `ObtenerSesionActual`).

- [ ] **Step 1: Test `iniciar_sesion_test.dart`** (mocktail):

```dart
// test/features/auth/domain/usecases/iniciar_sesion_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ligerito/core/errors/failures.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligerito/features/auth/domain/usecases/iniciar_sesion.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repo;
  late IniciarSesion usecase;

  final usuario = Usuario(
    id: 'u1', nombre: 'María', telefono: '911111111',
    rol: RolUsuario.cliente,
  );

  setUp(() {
    repo = MockAuthRepository();
    usecase = IniciarSesion(repo);
  });

  test('retorna ApiSuccess con usuario cuando el repo loguea', () async {
    when(() => repo.login(telefono: '911111111', password: '123456'))
        .thenAnswer((_) async => ApiSuccess(usuario));
    final result = await usecase(telefono: '911111111', password: '123456');
    expect(result, isA<ApiSuccess<Usuario>>());
    expect((result as ApiSuccess).data.nombre, 'María');
  });

  test('retorna ApiError con UnauthorizedFailure en credenciales malas', () async {
    when(() => repo.login(telefono: any(named: 'telefono'), password: any(named: 'password')))
        .thenAnswer((_) async => const ApiError(UnauthorizedFailure()));
    final result = await usecase(telefono: '900000000', password: 'mal123');
    expect(result, isA<ApiError<Usuario>>());
    expect((result as ApiError).failure, isA<UnauthorizedFailure>());
  });
}
```

- [ ] **Step 2: Correr — FALLA** → **Step 3: Implementar contratos + usecases** → **Step 4: verde** → **Step 5: codegen si aplica**.

### Task 2.2: Auth data (mock + remote + repo impl)

**Files:**
- Create: `lib/features/auth/data/models/usuario_model.dart` (DTO json_serializable para remote)
- Create: `lib/features/auth/data/datasources/mock_auth_datasource.dart`
- Create: `lib/features/auth/data/datasources/auth_remote_datasource.dart`
- Create: `lib/features/auth/data/repositories/auth_repository_impl.dart`

**Interfaces:**
- Produces:
  - `class MockAuthDatasource` — usuarios semilla: `911111111` (cliente "María Quispe"), `922222222` (negocio "Carlos Ramos", dueño del negocio `n1`); password cualquiera 6+. Latencia 800ms. Credenciales malas → `UnauthorizedException`. `register` crea en memoria con rol `cliente`; teléfono duplicado → `ValidationException({'telefono': ['El teléfono ya está registrado']})`.
  - `class AuthRemoteDatasource implements` mismo contrato, parseando envelope `{success, data, message, errors}` con `UsuarioModel.fromJson` (referencia del patrón Remote real).
  - `class AuthRepositoryImpl implements AuthRepository` — recibe el datasource por constructor; traduce excepciones → `ApiError` con el `Failure` correcto; en login/register exitoso persiste tokens vía `SecureStorageService`; `sesionActual()` lee token y valida contra datasource; `logout()` limpia storage.

- [ ] **Step 1: Implementar todo + codegen** → **Step 2: `flutter analyze` limpio.**

### Task 2.3: Auth presentation (providers + 4 pantallas)

**Files:**
- Create: `lib/features/auth/presentation/providers/sesion_controller.dart`
- Create: `lib/features/auth/presentation/providers/auth_providers.dart`
- Create: `lib/features/auth/presentation/screens/splash_screen.dart`
- Create: `lib/features/auth/presentation/screens/login_screen.dart`
- Create: `lib/features/auth/presentation/screens/registro_screen.dart`
- Create: `lib/features/auth/presentation/screens/recuperar_password_screen.dart`

**Interfaces:**
- Produces:
  - `@riverpod class SesionController extends _$SesionController` — `Future<SesionState> build()` resolviendo `obtenerSesionActual`; métodos `iniciarSesion`, `registrar`, `cerrarSesion`. `SesionState` sealed freezed: `cargando | autenticado(Usuario) | noAutenticado`.
  - `@riverpod AuthRepository authRepository(AuthRepositoryRef ref)` → `AuthRepositoryImpl(MockAuthDatasource(), ref.watch(secureStorageServiceProvider))` ← **LA línea de swap Mock→Remote.**
  - `static List<RouteBase> authRoutes` (login/registro/recuperar/splash screens reales).
  - Pantallas con criterios de aceptación sección 8.1: splash verifica token y redirige por rol; login valida teléfono/password ANTES de llamar API (validators de Task 1.4); 401 muestra exactamente "Teléfono o contraseña incorrectos" (`login_errorCredenciales`); registro rol `cliente` fijo (campo rol NO visible); botones con loading anti doble-tap; `LigeritoButton`/`LigeritoTextField`; `Semantics` en botón Ingresar.

- [ ] **Step 1: Providers + codegen** → **Step 2: Pantallas** → **Step 3: Orquestador enchufa `authRoutes` en `app_router` y conecta `SesionController` con el redirect del router (refreshListenable).**

- [ ] **Step 4: Verificación orquestador** — `flutter analyze` + `flutter test` verde; flujo splash→login→home navegable con mocks.

---

## OLA 2 (paralela) — Módulos 3, 9, 10

### Task 3.1: Catálogo — domain + data (Módulo 3) CON TEST

**Files:**
- Create: `lib/features/catalogo/domain/repositories/catalogo_repository.dart`
- Create: `lib/features/catalogo/domain/usecases/obtener_negocios.dart`
- Create: `lib/features/catalogo/domain/usecases/buscar_negocios.dart`
- Create: `lib/features/catalogo/data/datasources/mock_catalogo_datasource.dart`
- Create: `lib/features/catalogo/data/repositories/catalogo_repository_impl.dart`
- Test: `test/features/catalogo/domain/usecases/obtener_negocios_test.dart`

**Interfaces:**
- Produces:
  - `abstract class CatalogoRepository { Future<ApiResult<List<Negocio>>> obtenerNegocios({String? categoria, int page = 1}); Future<ApiResult<List<Negocio>>> buscarNegocios(String query); Future<ApiResult<Negocio>> obtenerDetalle(String id); Future<ApiResult<List<Producto>>> obtenerMenu(String negocioId); }`
  - Mock: 8 negocios de Piura con nombres reales-peruanos ("Pollería El Dorado", "Chifa San Joy Lao", "Farmacia Inkafarma Norte", "Mercado Modelo Fruits", "Ferretería El Tornillo Feliz"...), categorías del enum de strings (`restaurante`, `farmacia`, `mercado`, `ferreteria`), 2 cerrados, calificaciones 3.8–4.9, tiempos 15–50 min, `pedidoMinimo` 10–20 soles, coordenadas alrededor de Piura (-5.19, -80.63). Paginación de a 5. Búsqueda case-insensitive por nombre. Menú: 6–14 productos por negocio agrupados en 2–4 secciones ("Pollos", "Parrillas", "Bebidas"...), precios 5–45 soles en centavos, algunos `disponible: false`.

- [ ] **Steps: test mocktail del usecase → implementar → verde → analyze.**

### Task 3.2: Catálogo — Home screen

**Files:**
- Create: `lib/features/catalogo/presentation/providers/negocios_controller.dart`
- Create: `lib/features/catalogo/presentation/providers/busqueda_controller.dart`
- Create: `lib/features/catalogo/presentation/screens/home_screen.dart`
- Create: `lib/features/catalogo/presentation/widgets/negocio_card.dart`
- Create: `lib/features/catalogo/presentation/widgets/categoria_chip.dart`
- Create: `lib/features/catalogo/presentation/widgets/home_skeleton.dart`

**Interfaces / criterios (sección 8.2 EXACTA):** chips de categorías con scroll horizontal, filtro sin recargar pantalla (estado local en provider); paginación infinita con `ScrollController` + family por página; buscador con debounce 400ms (`Timer` en el controller, cancelar en dispose); empty → `EmptyStateView` con `home_vacioTitulo`; loading → `HomeSkeleton`; error → `ErrorView` reintentar. `NegocioCard` muestra logo (`CachedNetworkImage`), nombre, categoría, calificación ⭐, tiempo, costo envío (`CurrencyFormatter` sobre `(costoEnvioBase*100).round()`), badge Abierto/Cerrado; tap → `/negocio/:id`.

### Task 9.1: Perfil + direcciones (Módulo 9)

**Files:**
- Create: `lib/features/perfil/domain/repositories/perfil_repository.dart`
- Create: `lib/features/perfil/domain/usecases/{obtener_direcciones, guardar_direccion, eliminar_direccion}.dart`
- Create: `lib/features/perfil/data/datasources/mock_perfil_datasource.dart`
- Create: `lib/features/perfil/data/repositories/perfil_repository_impl.dart`
- Create: `lib/features/perfil/presentation/providers/{perfil_controller, direcciones_controller}.dart`
- Create: `lib/features/perfil/presentation/screens/{perfil_screen, direcciones_screen, editar_direccion_screen}.dart`
- Create: `lib/features/perfil/presentation/widgets/mapa_picker.dart`

**Interfaces:**
- `abstract class PerfilRepository { Future<ApiResult<List<Direccion>>> obtenerDirecciones(); Future<ApiResult<Direccion>> guardarDireccion(Direccion d); Future<ApiResult<void>> eliminarDireccion(String id); }`
- Mock semilla: 2 direcciones ("Casa" -5.1945,-80.6328; "Trabajo" -5.2012,-80.6390).
- `MapaPicker` — si `const String.fromEnvironment('MAPS_API_KEY').isNotEmpty` renderiza `GoogleMap` real con marker draggable y `geolocator` para ubicación actual; si no, placeholder gris con texto "Mapa disponible con API key" + campos lat/lng editables precargados con Piura centro. MISMA interfaz pública en ambos casos: `MapaPicker({required double latInicial, required double lngInicial, required void Function(double lat, double lng) onUbicacion})`.
- `perfil_screen`: datos del usuario (de `SesionController`), entrada a direcciones, botón `perfil_cerrarSesion` con diálogo de confirmación → logout → router redirige a login.
- `editar_direccion_screen`: form con `LigeritoTextField` (etiqueta, dirección, referencia) + `MapaPicker`; guardar vía `DireccionesController`.

### Task 10.1: Panel negocio — pedidos entrantes (Módulo 10) CON TEST

**Files:**
- Create: `lib/features/panel_negocio/domain/repositories/panel_repository.dart`
- Create: `lib/features/panel_negocio/domain/usecases/obtener_pedidos_entrantes.dart`
- Create: `lib/features/panel_negocio/domain/usecases/cambiar_estado_pedido.dart`
- Create: `lib/features/panel_negocio/data/datasources/mock_panel_datasource.dart`
- Create: `lib/features/panel_negocio/data/repositories/panel_repository_impl.dart`
- Create: `lib/features/panel_negocio/presentation/providers/pedidos_entrantes_controller.dart`
- Create: `lib/features/panel_negocio/presentation/screens/panel_pedidos_screen.dart`
- Create: `lib/features/panel_negocio/presentation/widgets/pedido_entrante_card.dart`
- Test: `test/features/panel_negocio/domain/usecases/cambiar_estado_pedido_test.dart`

**Interfaces:**
- `abstract class PanelRepository { Future<ApiResult<List<Pedido>>> pedidosEntrantes(); Future<ApiResult<Pedido>> cambiarEstado({required String pedidoId, required EstadoPedido nuevoEstado, int? tiempoEstimadoMin}); }`
- Mock: 4 pedidos pre-sembrados en estados variados (`pendiente`×2, `preparando`, `enCamino`) con `clienteNombre`/`clienteTelefono`; + generador que agrega 1 pedido nuevo simulado a los 20s de suscrito (para demo de notificación). Al suscribirse llega pedido nuevo → `PushService.mostrarNotificacionPedido(titulo: '¡Nuevo pedido!', cuerpo: ...)` (inyectar `PushService` por provider; default `LocalPushService`).
- Criterios sección 8.5 EXACTA: card muestra cliente, items, total (`CurrencyFormatter`), tiempo transcurrido (`DateFormatter.tiempoTranscurrido`); Aceptar/Rechazar con diálogo de confirmación; al aceptar, selector de tiempo estimado (+5/+10/+15 chips) antes de confirmar; sonido distintivo llega con la notificación local; `Semantics` en ambos botones; solicitar permiso de notificaciones al entrar a la pantalla.
- Test usecase `cambiar_estado_pedido_test.dart`: mocktail — aceptar cambia a `confirmado` con tiempo; rechazar a `cancelado`.

**Orquestador al cerrar Ola 2:** enchufar rutas de las 3 features en `app_router`, `flutter analyze` + `flutter test` verde.

---

## OLA 3 (paralela) — Módulos 4, 11, 12

### Task 4.1: Detalle negocio + menú agrupado (Módulo 4)

**Files:**
- Create: `lib/features/catalogo/presentation/providers/detalle_negocio_controller.dart`
- Create: `lib/features/catalogo/presentation/screens/detalle_negocio_screen.dart`
- Create: `lib/features/catalogo/presentation/widgets/producto_card.dart`
- Create: `lib/features/catalogo/presentation/widgets/menu_seccion.dart`

**Interfaces:** `@riverpod Future<...> detalleNegocio(ref, String id)` (negocio + menú agrupado por `seccionMenu` con `groupBy` manual); header con logo/hero, info (calificación, tiempo, envío, mínimo); lista `CustomScrollView` con `SliverAppBar` + secciones; `ProductoCard` con imagen, nombre, descripción, precio formateado, badge "No disponible" si aplica.
- **Integración con carrito (composition root, sin dependencia catalogo→carrito):** este task crea en `lib/features/catalogo/presentation/providers/agregar_al_carrito_provider.dart`:
```dart
typedef AgregarAlCarritoHandler = Future<ResultadoAgregar> Function({
  required Producto producto, required Negocio negocio});

typedef VaciarYAgregarHandler = Future<void> Function({
  required Producto producto, required Negocio negocio});

/// null = carrito no disponible (botones Agregar ocultos). Ola 4 lo overridea en app.dart.
@riverpod AgregarAlCarritoHandler? agregarAlCarritoHandler(ref) => null;
@riverpod VaciarYAgregarHandler? vaciarYAgregarHandler(ref) => null;
```
`ResultadoAgregar` se define en `lib/features/carrito/domain/entities/resultado_agregar.dart` por el orquestador en Fase 0 junto a las entidades (enum de 2 valores: `agregado, conflictoNegocio` — archivo propiedad del orquestador para que catalogo compile sin importar carrito). La pantalla: si el handler es `null`, oculta el botón Agregar; si no, lo muestra y: `agregado` → snackbar "Agregado"; `conflictoNegocio` → diálogo `carrito_conflicto*` y al confirmar llama `vaciarYAgregarHandler`.
- Estados: loading skeleton de menú / error reintentar / data.

### Task 11.1: Panel — CRUD menú/productos (Módulo 11) CON TEST

**Files:**
- Create: `lib/features/panel_negocio/domain/usecases/obtener_productos_negocio.dart`
- Create: `lib/features/panel_negocio/domain/usecases/guardar_producto.dart`
- Create: `lib/features/panel_negocio/domain/usecases/eliminar_producto.dart`
- Create: `lib/features/panel_negocio/presentation/providers/menu_controller.dart`
- Create: `lib/features/panel_negocio/presentation/screens/panel_menu_screen.dart`
- Create: `lib/features/panel_negocio/presentation/screens/editar_producto_screen.dart`
- Create: `lib/features/panel_negocio/presentation/widgets/producto_menu_tile.dart`
- Test: `test/features/panel_negocio/domain/usecases/guardar_producto_test.dart`

**Interfaces:** `PanelRepository` se EXTIENDE (mismo archivo, lo edita este subagente — es dueño de su feature): `Future<ApiResult<List<Producto>>> productosNegocio(); Future<ApiResult<Producto>> guardarProducto(Producto p); Future<ApiResult<void>> eliminarProducto(String id); Future<ApiResult<Producto>> toggleDisponibilidad(String id);`
- Criterios sección 8.6 EXACTA: CRUD con validación (nombre obligatorio, precio > 0 — validators de Task 1.4); toggle de disponibilidad con `Switch` en el tile SIN entrar a edición; imagen: `image_picker` (galería) → `flutter_image_compress` (`minWidth: 800, minHeight: 800, quality: 85`) → verificar ≤500KB (si excede, re-comprimir quality 70) → en mock se guarda path local como `imagenUrl`.
- Test `guardar_producto_test.dart`: valida que precio en centavos se persiste y que repo rechaza nombre vacío con `ValidationFailure`.

### Task 12.1: Panel — dashboard ventas del día (Módulo 12)

**Files:**
- Create: `lib/features/panel_negocio/domain/usecases/obtener_ventas_del_dia.dart`
- Create: `lib/features/panel_negocio/presentation/providers/dashboard_controller.dart`
- Create: `lib/features/panel_negocio/presentation/screens/panel_dashboard_screen.dart`
- Create: `lib/features/panel_negocio/presentation/widgets/ventas_resumen_card.dart`

**Interfaces:** `PanelRepository` += `Future<ApiResult<VentasDelDia>> ventasDelDia();` — entidad simple `VentasDelDia({int totalEnCentavos, int cantidadPedidos, int ticketPromedioEnCentavos})` en `panel_negocio/domain/entities/ventas_del_dia.dart` (la crea este subagente, es de su feature). Mock calcula sobre pedidos sembrados `entregado`/`enCamino` de hoy. UI: 3 `VentasResumenCard` (vendido hoy, pedidos, ticket promedio) + lista de últimos pedidos del día.

**Orquestador al cerrar Ola 3:** rutas, analyze, tests.

---

## OLA 4 (secuencial) — Módulos 5, 6

### Task 5.1: Carrito (Módulo 5) CON TEST

**Files:**
- Create: `lib/features/carrito/presentation/providers/carrito_controller.dart`
- Create: `lib/features/carrito/presentation/screens/carrito_screen.dart`
- Create: `lib/features/carrito/presentation/widgets/item_carrito_tile.dart`
- Test: `test/features/carrito/presentation/providers/carrito_controller_test.dart`

**Interfaces (patrón sección 6 EXACTO):**
- `@freezed CarritoState` sealed: `inicial()` | `conItems({required String negocioId, required String negocioNombre, required List<ItemCarrito> items, required int pedidoMinimoEnCentavos})` con getters `subtotalEnCentavos` (fold) y `alcanzaMinimo`.
- `@riverpod class CarritoController extends _$CarritoController` — `build() => const CarritoState.inicial()`; `ResultadoAgregar agregarItem({required Producto producto, required Negocio negocio, int cantidad = 1, String? notas})` (consume `ResultadoAgregar` de `carrito/domain/entities/resultado_agregar.dart`, creado en Fase 0); `void vaciarYAgregar({required Producto producto, required Negocio negocio, int cantidad = 1, String? notas})`; `quitarItem(String productoId)`, `actualizarCantidad(String productoId, int cantidad)` (cantidad 0 = quitar), `limpiar()`.
- Persistencia en memoria durante sesión (Notifier viva con `keepAlive`); se limpia al confirmar pedido o logout (orquestador conecta `SesionController` → `ref.invalidate`).
- **Wiring (orquestador, al cerrar este task):** en `app.dart` ProviderScope overrides: `agregarAlCarritoHandlerProvider.overrideWith((ref) => ({required producto, required negocio}) async => ref.read(carritoControllerProvider.notifier).agregarItem(producto: producto, negocio: negocio))` y `vaciarYAgregarHandlerProvider.overrideWith(...)` igual con `vaciarYAgregar`. Esto habilita los botones Agregar del detalle (Task 4.1).
- Pantalla: lista de items con stepper de cantidad y notas, subtotal por ítem, resumen subtotal/envío/total, validación pedido mínimo deshabilitando "Continuar" con mensaje `carrito_minimoNoAlcanzado`; empty → `EmptyStateView`.

- [ ] **Test `carrito_controller_test.dart`** — agregar item de negocio A → `conItems`; agregar de negocio B → `conflictoNegocio`; actualizar cantidad recalcula subtotal; quitar último item → `inicial`; cantidad 0 elimina item. Usar `ProviderContainer` directo.

### Task 6.1: Checkout (Módulo 6) CON TEST

**Files:**
- Create: `lib/features/pedidos/domain/repositories/pedidos_repository.dart`
- Create: `lib/features/pedidos/domain/usecases/crear_pedido.dart`
- Create: `lib/features/pedidos/data/datasources/mock_pedidos_datasource.dart`
- Create: `lib/features/pedidos/data/repositories/pedidos_repository_impl.dart`
- Create: `lib/features/pedidos/presentation/providers/checkout_controller.dart`
- Create: `lib/features/pedidos/presentation/screens/checkout_screen.dart`
- Create: `lib/features/pedidos/presentation/screens/pedido_confirmado_screen.dart`
- Create: `lib/features/pedidos/presentation/widgets/metodo_pago_selector.dart`
- Test: `test/features/pedidos/domain/usecases/crear_pedido_test.dart`

**Interfaces:**
- `abstract class PedidosRepository { Future<ApiResult<Pedido>> crearPedido({required String negocioId, required List<ItemCarrito> items, required MetodoPago metodoPago, required Direccion direccionEntrega, String? capturaPagoPath}); Future<ApiResult<Pedido>> obtenerPedido(String id); Future<ApiResult<List<Pedido>>> historial({int page = 1}); }`
- Mock pedidos: mantiene lista en memoria de pedidos creados en sesión; calcula `subtotalEnCentavos` (suma items), `costoEnvioEnCentavos` (`(negocio.costoEnvioBase*100).round()` vía lookup al mock de catálogo — importar SOLO domain `Negocio`, no data de catálogo: el mock de pedidos recibe el costo como parámetro... NO: viola el contrato. Solución: `MockPedidosDatasource` recibe por constructor un `double Function(String negocioId)? costoEnvioResolver` que el provider inyecta desde el mock de catálogo — composición en capa presentation/providers, mocks desacoplados).
- Criterios sección 8.3 (parte checkout) EXACTA: selector de método de pago (Yape/Plin/Efectivo — tarjeta fuera de MVP, no mostrar); Yape/Plin → muestra número del negocio (mock: `987 654 321`) + `checkout_yapeInstruccion` + botón adjuntar captura (`image_picker`); botón "Confirmar pedido" con loading anti doble-tap (`AsyncValue` en controller + disabled); éxito → limpia carrito → `/pedido/:id` confirmado con `pedido_confirmadoTitulo` + botón a seguimiento.
- Test `crear_pedido_test.dart`: mocktail — éxito retorna pedido con totales correctos (subtotal + envío = total).

---

## OLA 5 (secuencial) — Módulos 7, 8

### Task 7.1: Seguimiento de pedido (Módulo 7)

**Files:**
- Create: `lib/features/pedidos/presentation/providers/seguimiento_controller.dart`
- Create: `lib/features/pedidos/presentation/screens/seguimiento_pedido_screen.dart`
- Create: `lib/features/pedidos/presentation/widgets/estado_pedido_timeline.dart`
- Test: `test/features/pedidos/presentation/widgets/estado_pedido_timeline_test.dart`

**Interfaces:**
- `SeguimientoController` — `Stream<Pedido>` con polling cada 15s (`Stream.periodic` + `asyncExpand` al repo, cancelación automática por Riverpod al salir de pantalla). El mock avanza el estado del pedido automáticamente cada ~20s (`pendiente→confirmado→preparando→enCamino→entregado`) para demo viva.
- `EstadoPedidoTimeline({required EstadoPedido estadoActual})` — 5 estados visibles (pendiente→entregado; `cancelado` se muestra como banner rojo aparte), íconos + líneas, estado actual resaltado con `LigeritoColors.primary`, completados con `secondary`, pendientes gris; textos `estado_*` del arb; microcopy `seguimiento_casiLlega` cuando `enCamino`.
- Botón `seguimiento_contactar` → `url_launcher`? NO está en la tabla de paquetes permitidos. Decisión: abrir WhatsApp requiere `url_launcher` — NO aprobado por la regla dura. Alternativa dentro de la tabla: mostrar diálogo con número del negocio + botón copiar (Clipboard de Flutter, sin paquete). El criterio 8.4 dice "WhatsApp con mensaje prellenado" — esto REQUIERE `url_launcher`. **Justificación formal (regla de la sección 2):** la tabla no cubre abrir apps externas; `url_launcher` es el paquete oficial de Flutter para ello. → Se AGREGA `url_launcher: ^6.3.1` al pubspec con esta justificación documentada. Implementar `https://wa.me/51<telefono>?text=<mensaje prellenado con número de pedido>`.
- Test timeline: renderiza 5 estados; con `estadoActual: preparando` los índices 0-2 marcados; `cancelado` muestra banner.

### Task 8.1: Historial + repetir pedido (Módulo 8)

**Files:**
- Create: `lib/features/pedidos/presentation/providers/historial_controller.dart`
- Create: `lib/features/pedidos/presentation/screens/historial_pedidos_screen.dart`
- Create: `lib/features/pedidos/presentation/widgets/pedido_card.dart`

**Interfaces:** lista paginada del repo `historial(page:)`; `PedidoCard` (negocio — resolver nombre vía lookup al repo de catálogo por `negocioId`, fecha `DateFormatter.fechaHora`, total, badge estado con color por estado); tap → seguimiento/detalle; empty → `EmptyStateView` `historial_vacio*`.
- **Repetir pedido (composition root, sin dependencia pedidos→carrito):** este task crea `lib/features/pedidos/presentation/providers/repetir_pedido_provider.dart`:
```dart
typedef RepetirPedidoHandler = Future<String?> Function(Pedido pedido);
/// Retorna null si OK, o mensaje informativo (items omitidos). null provider = botón oculto.
@riverpod RepetirPedidoHandler? repetirPedidoHandler(ref) => null;
```
La pantalla: botón `historial_repetir` visible solo si el handler no es null; al tap llama al handler, muestra snackbar con el mensaje si retorna texto, y navega a `/carrito`.
- **Wiring (orquestador, al cerrar este task):** override en `app.dart`: el handler (1) lee `catalogoRepositoryProvider` y resuelve los productos actuales del pedido omitiendo los inexistentes o `disponible: false`, (2) si el carrito tiene items de otro negocio lo limpia, (3) carga items vía `carritoControllerProvider.notifier`, (4) retorna mensaje si hubo omitidos.

---

## VERIFICACIÓN FINAL (orquestador)

- [ ] `flutter analyze` — cero issues.
- [ ] `flutter test` — 100% verde (todos los tests de arriba).
- [ ] `flutter build apk --debug` compila.
- [ ] Checklist sección 11 del Prompt Maestro revisado módulo por módulo.
- [ ] Criterios de aceptación sección 8 (8.1–8.6) verificados contra la app corriendo (smoke manual con usuarios semilla `911111111` / `922222222`).
- [ ] Actualizar `README.md`: cómo correr, usuarios demo, cómo enchufar Firebase (`FirebasePushService implements PushService` + override provider), cómo activar Maps (`--dart-define=MAPS_API_KEY=...` + env var en gradle), cómo hacer swap Mock→Remote (1 línea en cada `*RepositoryProvider`), justificación de `url_launcher`.

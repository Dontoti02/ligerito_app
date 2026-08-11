# Auth Module Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the complete Auth module (splash, login, register, recover password) with real UI, mock repository, and tests — replacing all Phase 0 placeholders.

**Architecture:** Clean Architecture feature-first. Domain layer defines usecases and repository contract. Data layer provides mock implementation. Presentation layer uses Riverpod controllers and GoRouter for navigation.

**Tech Stack:** Flutter 3.19+, Dart 3.3+, flutter_riverpod, riverpod_annotation, freezed, go_router, google_fonts

## Global Constraints

- Material 3, LigeritoTheme.light (LigeritoColors.primary = 0xFFE63946)
- All strings via AppLocalizations (l10n), no hardcoded text
- All monetary amounts in centavos in domain/data, formatted only in presentation
- No `setState` for business logic (only for animations/trivial local UI)
- No `Dio` calls outside `data/datasources` (mock uses delay, not Dio)
- LigeritoButton, LigeritoTextField, SkeletonBox for UI components
- Route guards in `route_guards.dart` handle redirect logic
- Entities in Spanish, infrastructure in English
- File header comment with path as first line

---

## Task 1: Domain Layer — Auth Repository Contract

**Files:**
- Create: `lib/features/auth/domain/repositories/auth_repository.dart`
- Create: `lib/features/auth/domain/usecases/iniciar_sesion.dart`
- Create: `lib/features/auth/domain/usecases/registrar_usuario.dart`
- Create: `lib/features/auth/domain/usecases/cerrar_sesion.dart`

**Interfaces:**
- Consumes: `Usuario` entity from `lib/features/auth/domain/entities/usuario.dart`
- Produces: `AuthRepository` abstract class, `IniciarSesion`, `RegistrarUsuario`, `CerrarSesion` usecases

- [ ] **Step 1: Create AuthRepository abstract contract**

```dart
// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

abstract class AuthRepository {
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  });

  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  });

  Future<void> cerrarSesion();
}
```

- [ ] **Step 2: Create IniciarSesion usecase**

```dart
// lib/features/auth/domain/usecases/iniciar_sesion.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class IniciarSesion {
  final AuthRepository _repository;

  const IniciarSesion(this._repository);

  Future<ApiResult<Usuario>> call({
    required String telefono,
    required String password,
  }) {
    return _repository.iniciarSesion(telefono: telefono, password: password);
  }
}
```

- [ ] **Step 3: Create RegistrarUsuario usecase**

```dart
// lib/features/auth/domain/usecases/registrar_usuario.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class RegistrarUsuario {
  final AuthRepository _repository;

  const RegistrarUsuario(this._repository);

  Future<ApiResult<Usuario>> call({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) {
    return _repository.registrar(
      nombre: nombre,
      telefono: telefono,
      password: password,
      email: email,
    );
  }
}
```

- [ ] **Step 4: Create CerrarSesion usecase**

```dart
// lib/features/auth/domain/usecases/cerrar_sesion.dart
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

class CerrarSesion {
  final AuthRepository _repository;

  const CerrarSesion(this._repository);

  Future<void> call() => _repository.cerrarSesion();
}
```

- [ ] **Step 5: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/domain/`
Expected: No errors (warnings about unused imports are OK)

- [ ] **Step 6: Commit**

```bash
git add lib/features/auth/domain/
git commit -m "feat(auth): add domain layer — repository contract and usecases"
```

---

## Task 2: Data Layer — Mock Repository

**Files:**
- Create: `lib/features/auth/data/models/usuario_dto.dart`
- Create: `lib/features/auth/data/repositories/auth_repository_mock.dart`

**Interfaces:**
- Consumes: `AuthRepository` contract from Task 1, `Usuario` entity, `ApiResult` types
- Produces: `AuthRepositoryMock` class implementing `AuthRepository`

- [ ] **Step 1: Create UsuarioDto**

```dart
// lib/features/auth/data/models/usuario_dto.dart
import 'package:ligerito/features/auth/domain/entities/usuario.dart';

class UsuarioDto {
  final String id;
  final String nombre;
  final String telefono;
  final String? email;
  final RolUsuario rol;
  final String? fotoUrl;

  const UsuarioDto({
    required this.id,
    required this.nombre,
    required this.telefono,
    this.email,
    required this.rol,
    this.fotoUrl,
  });

  factory UsuarioDto.fromJson(Map<String, dynamic> json) {
    return UsuarioDto(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      telefono: json['telefono'] as String,
      email: json['email'] as String?,
      rol: RolUsuario.values.firstWhere(
        (r) => r.name == json['rol'],
        orElse: () => RolUsuario.cliente,
      ),
      fotoUrl: json['foto_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'telefono': telefono,
        'email': email,
        'rol': rol.name,
        'foto_url': fotoUrl,
      };

  Usuario toEntity() => Usuario(
        id: id,
        nombre: nombre,
        telefono: telefono,
        email: email,
        rol: rol,
        fotoUrl: fotoUrl,
      );
}
```

- [ ] **Step 2: Create AuthRepositoryMock**

```dart
// lib/features/auth/data/repositories/auth_repository_mock.dart
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/repositories/auth_repository.dart';

/// Mock de Fase 0: simula delay de API y retorna datos fake.
/// Credenciales válidas: teléfono 9 dígitos (empieza con 9) + password ≥ 6 chars.
/// Teléfonos 90/91/92 → rol negocio; otros → rol cliente.
class AuthRepositoryMock implements AuthRepository {
  @override
  Future<ApiResult<Usuario>> iniciarSesion({
    required String telefono,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (password.length < 6) {
      return const ApiError(ServerFailure('Teléfono o contraseña incorrectos'));
    }

    final esNegocio = telefono.startsWith('90') ||
        telefono.startsWith('91') ||
        telefono.startsWith('92');

    return ApiSuccess(Usuario(
      id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
      nombre: esNegocio ? 'Mi Negocio' : 'Cliente Demo',
      telefono: telefono,
      rol: esNegocio ? RolUsuario.negocio : RolUsuario.cliente,
    ));
  }

  @override
  Future<ApiResult<Usuario>> registrar({
    required String nombre,
    required String telefono,
    required String password,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    return ApiSuccess(Usuario(
      id: 'mock-${DateTime.now().millisecondsSinceEpoch}',
      nombre: nombre,
      telefono: telefono,
      email: email,
      rol: RolUsuario.cliente,
    ));
  }

  @override
  Future<void> cerrarSesion() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
```

- [ ] **Step 3: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/data/`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/auth/data/
git commit -m "feat(auth): add data layer — UsuarioDto and MockRepository"
```

---

## Task 3: Presentation — SesionController with Real Logic

**Files:**
- Modify: `lib/features/auth/presentation/providers/sesion_controller.dart`
- Modify: `lib/features/auth/presentation/providers/sesion_controller.g.dart` (regenerate)

**Interfaces:**
- Consumes: `IniciarSesion`, `RegistrarUsuario`, `CerrarSesion` usecases from Task 1, `AuthRepositoryMock` from Task 2
- Produces: `sesionControllerProvider` with `iniciarSesion()`, `registrar()`, `cerrarSesion()` methods

- [ ] **Step 1: Rewrite SesionController**

```dart
// lib/features/auth/presentation/providers/sesion_controller.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ligerito/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/domain/usecases/cerrar_sesion.dart';
import 'package:ligerito/features/auth/domain/usecases/iniciar_sesion.dart';
import 'package:ligerito/features/auth/domain/usecases/registrar_usuario.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sesion_controller.freezed.dart';
part 'sesion_controller.g.dart';

@freezed
sealed class SesionState with _$SesionState {
  const factory SesionState.cargando() = SesionCargando;
  const factory SesionState.autenticado(Usuario usuario) = SesionAutenticada;
  const factory SesionState.noAutenticado() = SesionNoAutenticado;
}

@Riverpod(keepAlive: true)
class SesionController extends _$SesionController {
  @override
  Future<SesionState> build() async => const SesionState.noAutenticado();

  Future<void> iniciarSesion(String telefono, String password) async {
    state = const AsyncData(SesionState.cargando());
    final repo = AuthRepositoryMock();
    final result = await IniciarSesion(repo).call(
      telefono: telefono,
      password: password,
    );
    state = AsyncData(
      result.when(
        success: (u) => SesionState.autenticado(u),
        error: (_) => const SesionState.noAutenticado(),
      ),
    );
  }

  Future<void> registrar(String nombre, String telefono, String password,
      {String? email}) async {
    state = const AsyncData(SesionState.cargando());
    final repo = AuthRepositoryMock();
    final result = await RegistrarUsuario(repo).call(
      nombre: nombre,
      telefono: telefono,
      password: password,
      email: email,
    );
    state = AsyncData(
      result.when(
        success: (u) => SesionState.autenticado(u),
        error: (_) => const SesionState.noAutenticado(),
      ),
    );
  }

  Future<void> cerrarSesion() async {
    final repo = AuthRepositoryMock();
    await CerrarSesion(repo).call();
    state = const AsyncData(SesionState.noAutenticado());
  }
}
```

- [ ] **Step 2: Run build_runner to regenerate**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart run build_runner build --delete-conflicting-outputs`
Expected: Generates `sesion_controller.freezed.dart` and `sesion_controller.g.dart` without errors

- [ ] **Step 3: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/providers/`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/features/auth/presentation/providers/sesion_controller.dart lib/features/auth/presentation/providers/sesion_controller.freezed.dart lib/features/auth/presentation/providers/sesion_controller.g.dart
git commit -m "feat(auth): update SesionController with real login/register/logout logic"
```

---

## Task 4: Presentation — Auth Header Widget

**Files:**
- Create: `lib/features/auth/presentation/widgets/auth_header.dart`

**Interfaces:**
- Consumes: `LigeritoColors`, `AppLocalizations`
- Produces: `AuthHeader` widget used by login, register, recover screens

- [ ] **Step 1: Create AuthHeader widget**

```dart
// lib/features/auth/presentation/widgets/auth_header.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/l10n/app_localizations.dart';

/// Header reutilizable para pantallas de auth: logo + título + subtítulo.
class AuthHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const AuthHeader({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 48),
        const Icon(
          Icons.bolt,
          size: 72,
          color: LigeritoColors.primary,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.appName,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: LigeritoColors.primary,
              ),
        ),
        const SizedBox(height: 32),
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        if (title != null) const SizedBox(height: 8),
        if (subtitle != null)
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: LigeritoColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
```

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/widgets/`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/widgets/auth_header.dart
git commit -m "feat(auth): add reusable AuthHeader widget"
```

---

## Task 5: Presentation — Login Screen

**Files:**
- Create: `lib/features/auth/presentation/screens/login_screen.dart`

**Interfaces:**
- Consumes: `sesionControllerProvider` from Task 3, `AuthHeader` from Task 4, `LigeritoValidators`, `LigeritoButton`, `LigeritoTextField`, `AppLocalizations`
- Produces: `LoginScreen` widget (replaces placeholder in router)

- [ ] **Step 1: Create LoginScreen**

```dart
// lib/features/auth/presentation/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _telefonoCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(sesionControllerProvider.notifier).iniciarSesion(
          _telefonoCtrl.text.trim(),
          _passwordCtrl.text,
        );
    if (!mounted) return;
    final sesion = ref.read(sesionControllerProvider).valueOrNull;
    if (sesion is SesionAutenticada) {
      final ruta = sesion.usuario.rol == RolUsuario.negocio
          ? '/panel/pedidos'
          : '/home';
      context.go(ruta);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loginErrorCredenciales),
          backgroundColor: LigeritoColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sesion = ref.watch(sesionControllerProvider);
    final isLoading = sesion.valueOrNull is SesionCargando;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.loginTitulo,
                  subtitle: l10n.loginSubtitulo,
                ),
                LigeritoTextField(
                  label: l10n.loginTelefono,
                  hint: '999123456',
                  controller: _telefonoCtrl,
                  validator: LigeritoValidators.telefono,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.loginPassword,
                  controller: _passwordCtrl,
                  validator: LigeritoValidators.password,
                  obscureText: _obscurePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: LigeritoColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 8),
                LigeritoButton(
                  label: l10n.loginBoton,
                  onPressed: _submit,
                  loading: isLoading,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/recuperar'),
                  child: Text(
                    l10n.loginOlvidaste,
                    style: const TextStyle(color: LigeritoColors.textSecondary),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/registro'),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${l10n.loginSinCuenta.split('? ')[0]}? ',
                        ),
                        TextSpan(
                          text: l10n.loginSinCuenta.split('? ').last,
                          style: const TextStyle(
                            color: LigeritoColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/screens/login_screen.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/screens/login_screen.dart
git commit -m "feat(auth): add LoginScreen with form validation and mock flow"
```

---

## Task 6: Presentation — Register Screen

**Files:**
- Create: `lib/features/auth/presentation/screens/registro_screen.dart`

**Interfaces:**
- Consumes: `sesionControllerProvider` from Task 3, `AuthHeader` from Task 4, `LigeritoValidators`, `LigeritoButton`, `LigeritoTextField`, `AppLocalizations`
- Produces: `RegistroScreen` widget

- [ ] **Step 1: Create RegistroScreen**

```dart
// lib/features/auth/presentation/screens/registro_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class RegistroScreen extends ConsumerStatefulWidget {
  const RegistroScreen({super.key});

  @override
  ConsumerState<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends ConsumerState<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(sesionControllerProvider.notifier).registrar(
          _nombreCtrl.text.trim(),
          _telefonoCtrl.text.trim(),
          _passwordCtrl.text,
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        );
    if (!mounted) return;
    final sesion = ref.read(sesionControllerProvider).valueOrNull;
    if (sesion is SesionAutenticada) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.registroExito),
          backgroundColor: LigeritoColors.secondary,
        ),
      );
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sesion = ref.watch(sesionControllerProvider);
    final isLoading = sesion.valueOrNull is SesionCargando;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.registroTitulo,
                  subtitle: l10n.tagline,
                ),
                LigeritoTextField(
                  label: l10n.registroNombre,
                  controller: _nombreCtrl,
                  validator: LigeritoValidators.nombreObligatorio,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.loginTelefono,
                  hint: '999123456',
                  controller: _telefonoCtrl,
                  validator: LigeritoValidators.telefono,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.registroEmail,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                LigeritoTextField(
                  label: l10n.loginPassword,
                  controller: _passwordCtrl,
                  validator: LigeritoValidators.password,
                  obscureText: _obscurePassword,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: LigeritoColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 8),
                LigeritoButton(
                  label: l10n.registroBoton,
                  onPressed: _submit,
                  loading: isLoading,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        const TextSpan(text: '¿Ya tienes cuenta? '),
                        TextSpan(
                          text: 'Inicia sesión',
                          style: const TextStyle(
                            color: LigeritoColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/screens/registro_screen.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/screens/registro_screen.dart
git commit -m "feat(auth): add RegistroScreen with form validation and mock flow"
```

---

## Task 7: Presentation — Recover Password Screen

**Files:**
- Create: `lib/features/auth/presentation/screens/recuperar_screen.dart`

**Interfaces:**
- Consumes: `AuthHeader` from Task 4, `LigeritoValidators`, `LigeritoButton`, `LigeritoTextField`, `AppLocalizations`
- Produces: `RecuperarScreen` widget

- [ ] **Step 1: Create RecuperarScreen**

```dart
// lib/features/auth/presentation/screens/recuperar_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/utils/validators.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';
import 'package:ligerito/features/auth/presentation/widgets/auth_header.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class RecuperarScreen extends StatefulWidget {
  const RecuperarScreen({super.key});

  @override
  State<RecuperarScreen> createState() => _RecuperarScreenState();
}

class _RecuperarScreenState extends State<RecuperarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _telefonoCtrl = TextEditingController();
  bool _enviado = false;

  @override
  void dispose() {
    _telefonoCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _enviado = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: l10n.recuperarTitulo,
                  subtitle: l10n.recuperarMensaje,
                ),
                if (_enviado) ...[
                  const Icon(Icons.check_circle_outline,
                      size: 64, color: LigeritoColors.secondary),
                  const SizedBox(height: 16),
                  Text(
                    'Te enviaremos las instrucciones a tu teléfono ${_telefonoCtrl.text}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  LigeritoButton(
                    label: l10n.comunAceptar,
                    onPressed: () => context.go('/login'),
                  ),
                ] else ...[
                  LigeritoTextField(
                    label: l10n.loginTelefono,
                    hint: '999123456',
                    controller: _telefonoCtrl,
                    validator: LigeritoValidators.telefono,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  LigeritoButton(
                    label: l10n.recuperarBoton,
                    onPressed: _submit,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/screens/recuperar_screen.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/screens/recuperar_screen.dart
git commit -m "feat(auth): add RecuperarScreen with confirmation state"
```

---

## Task 8: Presentation — Splash Screen

**Files:**
- Create: `lib/features/auth/presentation/screens/splash_screen.dart`

**Interfaces:**
- Consumes: `LigeritoColors`, `AppLocalizations`
- Produces: `SplashScreen` widget

- [ ] **Step 1: Create SplashScreen**

```dart
// lib/features/auth/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // La redirección la maneja routeGuard en app_router.dart
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: LigeritoColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bolt,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.appName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.tagline,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/features/auth/presentation/screens/splash_screen.dart`
Expected: No errors

- [ ] **Step 3: Commit**

```bash
git add lib/features/auth/presentation/screens/splash_screen.dart
git commit -m "feat(auth): add SplashScreen with logo and tagline"
```

---

## Task 9: Update Router — Replace Placeholders

**Files:**
- Modify: `lib/core/router/app_router.dart`

**Interfaces:**
- Consumes: All screens from Tasks 5-8
- Produces: Updated router with real screen widgets instead of `ModuloPlaceholderScreen`

- [ ] **Step 1: Update router imports and routes**

Replace the placeholder routes in `app_router.dart`. Keep `ModuloPlaceholderScreen` class and all non-auth routes untouched. Only change auth-related routes:

```dart
// In app_router.dart, add these imports at the top:
import 'package:ligerito/features/auth/presentation/screens/splash_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/login_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/registro_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/recuperar_screen.dart';
```

Then replace the route builders:
- `/splash` → `const SplashScreen()`
- `/login` → `const LoginScreen()`
- `/registro` → `const RegistroScreen()`
- `/recuperar` → `const RecuperarScreen()`

- [ ] **Step 2: Verify compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/core/router/app_router.dart`
Expected: No errors

- [ ] **Step 3: Verify full project compilation**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze lib/`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
git add lib/core/router/app_router.dart
git commit -m "feat(auth): replace auth placeholders with real screens in router"
```

---

## Task 10: Write Unit Tests

**Files:**
- Create: `test/features/auth/domain/usecases/iniciar_sesion_test.dart`
- Create: `test/features/auth/presentation/providers/sesion_controller_test.dart`

**Interfaces:**
- Consumes: `IniciarSesion` usecase, `SesionController`, `AuthRepositoryMock`
- Produces: Passing unit tests

- [ ] **Step 1: Create IniciarSesion test**

```dart
// test/features/auth/domain/usecases/iniciar_sesion_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/network/api_result.dart';
import 'package:ligerito/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:ligerito/features/auth/domain/usecases/iniciar_sesion.dart';

void main() {
  late IniciarSesion usecase;
  late AuthRepositoryMock repo;

  setUp(() {
    repo = AuthRepositoryMock();
    usecase = IniciarSesion(repo);
  });

  test('retorna usuario con rol cliente para teléfono genérico', () async {
    final result = await usecase.call(
      telefono: '999123456',
      password: '123456',
    );

    expect(result, isA<ApiSuccess>());
    result.when(
      success: (u) {
        expect(u.telefono, '999123456');
        expect(u.rol.name, 'cliente');
      },
      error: (_) => fail('No debería fallar'),
    );
  });

  test('retorna usuario con rol negocio para teléfono 90/91/92', () async {
    final result = await usecase.call(
      telefono: '901234567',
      password: '123456',
    );

    expect(result, isA<ApiSuccess>());
    result.when(
      success: (u) => expect(u.rol.name, 'negocio'),
      error: (_) => fail('No debería fallar'),
    );
  });

  test('retorna error si password tiene menos de 6 caracteres', () async {
    final result = await usecase.call(
      telefono: '999123456',
      password: '123',
    );

    expect(result, isA<ApiError>());
  });
}
```

- [ ] **Step 2: Run test to verify it passes**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && flutter test test/features/auth/domain/usecases/iniciar_sesion_test.dart`
Expected: 3 tests passed

- [ ] **Step 3: Create SesionController test**

```dart
// test/features/auth/presentation/providers/sesion_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';

void main() {
  group('SesionController', () {
    test('estado inicial es noAutenticado', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(sesionControllerProvider.future);
      expect(state, isA<SesionNoAutenticado>());
    });

    test('iniciarSesion con credenciales válidas autentica', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Esperar estado inicial
      await container.read(sesionControllerProvider.future);

      await container
          .read(sesionControllerProvider.notifier)
          .iniciarSesion('999123456', '123456');

      final state = container.read(sesionControllerProvider).valueOrNull;
      expect(state, isA<SesionAutenticada>());
    });

    test('iniciarSesion con password corta falla', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(sesionControllerProvider.future);

      await container
          .read(sesionControllerProvider.notifier)
          .iniciarSesion('999123456', '123');

      final state = container.read(sesionControllerProvider).valueOrNull;
      expect(state, isA<SesionNoAutenticado>());
    });

    test('cerrarSesion limpia la sesión', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(sesionControllerProvider.future);

      await container
          .read(sesionControllerProvider.notifier)
          .iniciarSesion('999123456', '123456');

      await container.read(sesionControllerProvider.notifier).cerrarSesion();

      final state = container.read(sesionControllerProvider).valueOrNull;
      expect(state, isA<SesionNoAutenticado>());
    });
  });
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && flutter test test/features/auth/presentation/providers/sesion_controller_test.dart`
Expected: 4 tests passed

- [ ] **Step 5: Run all tests**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && flutter test`
Expected: All tests pass

- [ ] **Step 6: Commit**

```bash
git add test/features/auth/
git commit -m "test(auth): add unit tests for IniciarSesion and SesionController"
```

---

## Task 11: Final Verification

- [ ] **Step 1: Run full analysis**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && dart analyze`
Expected: No errors

- [ ] **Step 2: Run all tests**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && flutter test`
Expected: All tests pass

- [ ] **Step 3: Verify app builds**

Run: `cd C:\Users\LOPEZ\AndroidStudioProjects\ligerito && flutter build apk --debug`
Expected: Build succeeds

- [ ] **Step 4: Final commit if any fixes needed**

```bash
git add -A
git commit -m "feat(auth): complete Auth module — splash, login, register, recover"
```

# Login Visual Refresh Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the login screen's visual composition to match the supplied hero-and-form layout without changing authentication behavior.

**Architecture:** Keep `LoginScreen` as the routed `ConsumerStatefulWidget` and preserve its controllers, form key, submit method, provider subscription, loading state, and route actions. Replace only the widget tree in `build` with the supplied layout translated to the app's existing phone fields and Spanish localization.

**Tech Stack:** Flutter, Dart, Riverpod, Material 3, `AppLocalizations`, `flutter_test`.

## Global Constraints

- Only the presentation tree of `lib/features/auth/presentation/screens/login_screen.dart` changes.
- Phone and password controllers and validators remain unchanged.
- Form submission continues through `SesionController.iniciarSesion`.
- Loading state remains on the primary action.
- Redirects and recovery/registration routes remain unchanged.
- Spanish strings continue to come from `AppLocalizations`.
- Do not modify authentication providers, data sources, localization files, router files, or unrelated worktree changes.

---

### Task 1: Add a Login Visual Regression Test

**Files:**
- Create: `test/features/auth/presentation/screens/login_screen_test.dart`
- Read: `lib/features/auth/presentation/screens/login_screen.dart`

**Interfaces:**
- Consumes: `LoginScreen`, `SesionState.noAutenticado`, `sesionControllerProvider`, and `AppLocalizations`.
- Produces: widget coverage for the hero composition and password visibility control.

- [ ] **Step 1: Write the failing widget test**

Create the test with a fake session controller so the screen can render without
calling storage or the remote repository:

```dart
// test/features/auth/presentation/screens/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/screens/login_screen.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class _FakeSesionController extends SesionController {
  @override
  Future<SesionState> build() async => const SesionState.noAutenticado();
}

Future<void> _pumpLogin(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sesionControllerProvider.overrideWith(_FakeSesionController.new),
      ],
      child: MaterialApp(
        locale: const Locale('es', 'PE'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoginScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('muestra la nueva composición visual del login', (tester) async {
    await _pumpLogin(tester);

    expect(find.byIcon(Icons.lock_person_rounded), findsOneWidget);
    expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    expect(find.text('¡Qué bueno verte!'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });

  testWidgets('alterna la visibilidad de la contraseña', (tester) async {
    await _pumpLogin(tester);

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}
```

- [ ] **Step 2: Run the focused test and confirm it fails for the missing design**

Run:

```bash
flutter test test/features/auth/presentation/screens/login_screen_test.dart
```

Expected: FAIL because the current screen does not contain the
`lock_person_rounded` hero icon and the new leading field icons.

### Task 2: Replace Only the Login Presentation Tree

**Files:**
- Modify: `lib/features/auth/presentation/screens/login_screen.dart:5-12,57-143`
- Test: `test/features/auth/presentation/screens/login_screen_test.dart`

**Interfaces:**
- Consumes: the existing `_formKey`, `_telefonoCtrl`, `_passwordCtrl`,
  `_obscurePassword`, `_submit`, `isLoading`, localization, and `ThemeData`.
- Produces: the same `LoginScreen` route with the new hero-and-form layout.

- [ ] **Step 1: Remove only obsolete presentation imports**

Remove the imports for `LigeritoButton`, `LigeritoTextField`, and `AuthHeader`.
Keep `LigeritoColors` because the existing `_submit` method uses its error
color, along with Flutter, Riverpod, GoRouter, validators, domain state,
session controller, and localization imports.

- [ ] **Step 2: Replace `build` with the new layout**

Keep `_submit`, `dispose`, all controllers, and `_obscurePassword` unchanged.
Use this `build` implementation:

```dart
@override
Widget build(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final sesion = ref.watch(sesionControllerProvider);
  final isLoading = sesion.valueOrNull is SesionCargando;
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;

  return Scaffold(
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 24),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.lock_person_rounded,
                size: 72,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.loginTitulo,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.loginSubtitulo,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _telefonoCtrl,
              validator: LigeritoValidators.telefono,
              keyboardType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: l10n.loginTelefono,
                prefixIcon: const Icon(Icons.phone_outlined),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordCtrl,
              validator: LigeritoValidators.password,
              obscureText: _obscurePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: l10n.loginPassword,
                prefixIcon: const Icon(Icons.lock_outline),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => setState(
                    () => _obscurePassword = !_obscurePassword,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/recuperar'),
                child: Text(l10n.loginOlvidaste),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.loginBoton),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l10n.loginSinCuenta.split('? ').first}?',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                TextButton(
                  onPressed: () => context.go('/registro'),
                  child: Text(l10n.loginSinCuenta.split('? ').last),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
```

- [ ] **Step 3: Run the focused test and confirm it passes**

Run:

```bash
flutter test test/features/auth/presentation/screens/login_screen_test.dart
```

Expected: both widget tests pass.

### Task 3: Verify the Complete Login Refresh

**Files:**
- Verify: `lib/features/auth/presentation/screens/login_screen.dart`
- Verify: `test/features/auth/presentation/screens/login_screen_test.dart`

- [ ] **Step 1: Run static analysis**

Run:

```bash
flutter analyze
```

Expected: no new errors caused by the login refresh. Existing unrelated info
diagnostics may remain outside the touched files.

- [ ] **Step 2: Run the complete test suite**

Run:

```bash
flutter test
```

Expected: all existing and new tests pass.

- [ ] **Step 3: Run the app on Android**

Run:

```bash
flutter run -d CPH2639 --debug --no-resident
```

Expected: the debug APK builds, installs, and starts. Confirm the hero card,
localized title, phone/password icons, password toggle, validation, recovery
route, and registration route render correctly. Confirm no provider, API, or
router files changed.

No commit is made unless the user explicitly requests one.

## Plan Self-Review

- Spec coverage: the plan preserves all listed authentication contracts and
  implements every visual requirement in one screen.
- Placeholder scan: no `TODO`, `TBD`, or unspecified implementation steps.
- Type consistency: the test override uses `SesionController`, the production
  code continues to call `SesionController.iniciarSesion`, and all route names
  match the current router (`/recuperar` and `/registro`).

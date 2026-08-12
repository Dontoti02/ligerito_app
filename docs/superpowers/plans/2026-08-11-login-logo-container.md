# Login Logo Container Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the login lock icon with the supplied logo so the logo fills the existing 160 px hero container without distortion.

**Architecture:** Keep `LoginScreen` as the existing routed `ConsumerStatefulWidget`. Change only its hero presentation widget and update the focused widget regression test; controllers, authentication state, localization, and routes remain untouched.

**Tech Stack:** Flutter, Dart, Material 3, Riverpod, `flutter_test`.

## Global Constraints

- Keep the hero at full available width and 160 px high.
- Keep 24 px rounded corners and clip the logo to them.
- Render `assets/logo.png` with `BoxFit.cover`.
- Keep phone/password validation, authentication, loading, errors, redirects, recovery, registration, and localized strings unchanged.
- Do not add dependencies or replace the existing `assets/logo.png` asset.
- Do not modify authentication providers, repositories, router files, or unrelated worktree changes.

---

### Task 1: Update the Login Visual Regression Test

**Files:**
- Modify: `test/features/auth/presentation/screens/login_screen_test.dart:31-50`
- Read: `lib/features/auth/presentation/screens/login_screen.dart`

**Interfaces:**
- Consumes: `LoginScreen`, the fake `SesionController` override, and Spanish localization setup already present in the test.
- Produces: a focused assertion for the keyed login logo while retaining the password visibility coverage.

- [ ] **Step 1: Replace the icon expectation with a logo expectation**

Keep the test setup and replace the `main` function with:

```dart
void main() {
  testWidgets('muestra la nueva composición visual del login', (tester) async {
    await _pumpLogin(tester);

    expect(
      find.byKey(const ValueKey<String>('login-logo')),
      findsOneWidget,
    );
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

- [ ] **Step 2: Run the focused test and confirm the red state**

Run:

```bash
flutter test test/features/auth/presentation/screens/login_screen_test.dart
```

Expected: FAIL because the current login hero has no `login-logo` key and still
renders the lock icon.

### Task 2: Replace the Login Hero With the Logo

**Files:**
- Modify: `lib/features/auth/presentation/screens/login_screen.dart:70-82`
- Test: `test/features/auth/presentation/screens/login_screen_test.dart`

**Interfaces:**
- Consumes: the existing `ThemeData`, form layout, and `assets/logo.png` asset declaration.
- Produces: the same login screen with a clipped, full-size logo hero.

- [ ] **Step 1: Replace the hero container and icon**

Replace the current `Container` from `const SizedBox(height: 24)` through its
closing widget with this block, leaving all following form widgets unchanged:

```dart
const SizedBox(height: 24),
ClipRRect(
  borderRadius: BorderRadius.circular(24),
  child: Image.asset(
    'assets/logo.png',
    key: const ValueKey<String>('login-logo'),
    width: double.infinity,
    height: 160,
    fit: BoxFit.cover,
  ),
),
```

- [ ] **Step 2: Run the focused test and confirm the green state**

Run:

```bash
flutter test test/features/auth/presentation/screens/login_screen_test.dart
```

Expected: PASS for both login widget tests.

- [ ] **Step 3: Commit the implementation and focused test**

Inspect the worktree before staging, then stage only the two implementation
files and commit the green change:

```bash
git status --short
git diff --check
git diff --stat
git log --oneline -10
git add -- lib/features/auth/presentation/screens/login_screen.dart test/features/auth/presentation/screens/login_screen_test.dart
git commit -m "feat: use brand logo in login hero"
```

### Task 3: Verify and Publish the Login Change

**Files:**
- Verify: `lib/features/auth/presentation/screens/login_screen.dart`
- Verify: `test/features/auth/presentation/screens/login_screen_test.dart`

**Interfaces:**
- Consumes: the committed login implementation and existing Flutter project configuration.
- Produces: verified commits published to the requested `origin/master` remote.

- [ ] **Step 1: Run static analysis**

Run:

```bash
flutter analyze
```

Expected: analysis completes without errors caused by the logo change.

- [ ] **Step 2: Run the complete test suite**

Run:

```bash
flutter test
```

Expected: all tests pass.

- [ ] **Step 3: Build and start the Android app when a device is available**

Run:

```bash
flutter run -d CPH2639 --debug --no-resident
```

Expected: the app starts and the login hero fills its rounded 160 px area with
the logo while the form and existing navigation remain usable.

- [ ] **Step 4: Push the design and implementation commits**

Confirm the remote and clean staged state, then publish the commits:

```bash
git remote -v
git status --short --branch
git push origin master
```

Expected: `origin/master` advances successfully at
`https://github.com/Dontoti02/ligerito_app.git`.

## Plan Self-Review

- Spec coverage: the plan covers the full-width 160 px hero, 24 px clipping,
  `BoxFit.cover`, unchanged authentication contracts, focused tests, analysis,
  full tests, Android launch, and remote publication.
- Placeholder scan: every step has a concrete file, code block, command, and
  expected result; no `TODO`, `TBD`, or deferred implementation remains.
- Type consistency: the production and test code use the same
  `ValueKey<String>('login-logo')`, and the existing `SesionController` test
  override remains unchanged.

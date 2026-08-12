# Remove Flutter Debug Banner Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Hide only Flutter's red `DEBUG` banner while keeping the app running in debug mode.

**Architecture:** Configure the existing root `MaterialApp.router` in `LigeritoApp`. No screens, routes, providers, themes, logging, or error handling change.

**Tech Stack:** Flutter, Dart, `MaterialApp.router`, Flutter test and analyzer commands.

## Global Constraints

- Only `lib/app.dart` changes in production code.
- Preserve debug-mode behavior, logging, and development tooling.
- Do not modify unrelated worktree changes.
- The red `DEBUG` banner must be absent when the app runs.

---

### Task 1: Disable the Root Debug Banner

**Files:**
- Modify: `lib/app.dart:14-21`
- Verify: existing Flutter test suite and analyzer; no new test file is needed because this is a single framework configuration property.

**Interfaces:**
- Consumes: the existing `MaterialApp.router` configuration and `appRouterProvider`.
- Produces: an app root with `debugShowCheckedModeBanner` set to `false`.

- [ ] **Step 1: Add the minimal configuration property**

Update the existing return value in `LigeritoApp.build` so it includes the property:

```dart
return MaterialApp.router(
  title: 'Ligerito',
  debugShowCheckedModeBanner: false,
  theme: LigeritoTheme.light,
  routerConfig: router,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  locale: const Locale('es', 'PE'),
);
```

- [ ] **Step 2: Run static analysis**

Run:

```bash
flutter analyze
```

Expected: analysis completes without errors.

- [ ] **Step 3: Run the existing tests**

Run:

```bash
flutter test
```

Expected: all existing tests pass.

- [ ] **Step 4: Confirm the running app has no banner**

Hot reload or restart the app on the connected Android device. Confirm the UI
still loads normally and the red `DEBUG` label is no longer visible. Confirm
that debug logs and the rest of the development behavior remain available.

No commit is made unless the user explicitly requests one.

## Plan Self-Review

- Spec coverage: the plan changes only `lib/app.dart`, preserves debug mode,
  and includes analyzer, test, and runtime verification.
- Placeholder scan: no `TODO`, `TBD`, or unspecified implementation steps.
- Type and name consistency: `LigeritoApp`, `MaterialApp.router`, and
  `debugShowCheckedModeBanner` match the current source code.

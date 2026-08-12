# Remove Flutter Debug Banner

## Goal

Remove the red `DEBUG` label shown in the running Android app while preserving
debug-mode behavior, logging, and development tooling.

## Design

Set `debugShowCheckedModeBanner: false` on the existing `MaterialApp.router`
in `lib/app.dart`. This is the Flutter configuration property that controls
the checked-mode banner, so the change affects only that visible overlay.

No screens, routing, themes, state management, or error handling will change.

## Verification

- Run `flutter analyze`.
- Run the existing test suite with `flutter test`.
- Confirm the app still starts and the red `DEBUG` banner is absent.

## Scope

Only `lib/app.dart` and this specification are part of this change. Existing
unrelated worktree changes must remain untouched.

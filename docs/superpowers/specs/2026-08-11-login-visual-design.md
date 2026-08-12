# Login Visual Refresh

## Goal

Adapt the existing login screen to the supplied visual composition while
keeping its current authentication behavior unchanged.

## Scope

Only the presentation tree of
`lib/features/auth/presentation/screens/login_screen.dart` changes. The
following contracts remain intact:

- Phone and password controllers and validators.
- Form submission through `SesionController.iniciarSesion`.
- Loading state on the primary action.
- Redirects to the client or business home after authentication.
- Recovery and registration routes.
- Spanish strings from `AppLocalizations`.

Email input, English copy, persistence for "Remember me", providers, API
repositories, router configuration, and other screens are out of scope.

## Visual Design

- Use `SafeArea` with a scrollable vertical layout and 24px horizontal padding.
- Replace the current header with a 160px-high, full-width hero container using
  `colorScheme.primaryContainer`, 24px corners, and a centered lock-person
  icon.
- Render the localized login title and subtitle below the hero.
- Use outlined form fields with leading phone/lock icons and keep the password
  visibility control inside the password field as a trailing icon.
- Keep the primary action at 52px height and show the existing loading state.
- Keep the recovery action and registration action below the button, using the
  existing routes and localized labels.

## Error Handling

Validation and authentication errors continue to use the current form and
`SnackBar` flow. The visual refresh must not introduce new error states or
change the messages.

## Verification

- Run `flutter analyze`.
- Run `flutter test`.
- Run the app on the connected Android device and confirm the new arrangement
  renders, the password visibility control works, validation still appears,
  and the existing routes remain reachable.

## Constraints

Do not modify authentication providers, data sources, localization files,
router files, or unrelated existing worktree changes.

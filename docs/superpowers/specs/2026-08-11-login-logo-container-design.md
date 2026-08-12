# Login Logo Container

## Goal

Replace the lock icon in the login hero with the supplied Ligerito logo so the
image fills the same 160 px hero container already present on the screen.

## Scope

Only the login presentation tree and its focused widget test change. The
following behavior remains unchanged:

- Phone and password controllers and validators.
- Authentication through `SesionController.iniciarSesion`.
- Loading and authentication error states.
- Client and business redirects.
- Recovery and registration routes.
- Localized Spanish strings.

The existing `assets/logo.png` asset is reused; no new asset or dependency is
required.

## Visual Design

- Keep the hero at full available width and 160 px high.
- Keep 24 px rounded corners.
- Clip the image to those rounded corners.
- Render `assets/logo.png` with `BoxFit.cover` so it fills the entire hero
  area without stretching or distorting the logo.
- Keep the rest of the login form unchanged.

## Testing

Update the login widget test to assert that the keyed logo image is present.
Retain the password visibility test and run the focused test, full test suite,
and static analysis.

## Delivery

Commit the design and implementation changes, then push them to the configured
`origin/master` remote at `https://github.com/Dontoti02/ligerito_app.git`.

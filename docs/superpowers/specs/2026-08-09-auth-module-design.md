# Diseño: Módulo Auth Completo — Ligerito

**Fecha:** 2026-08-09
**Alcance:** Ola 2 del PROMPT_MAESTRO — Auth completo (login, registro, recuperar contraseña)

---

## 1. Objetivo

Implementar las pantallas de autenticación con UI real, reemplazando los placeholders de Fase 0. Incluye splash, login, registro y recuperar contraseña, con mock repository funcional que simula llamadas API.

## 2. Archivos a crear/modificar

### Domain layer
| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `lib/features/auth/domain/repositories/auth_repository.dart` | Crear | Contrato abstracto |
| `lib/features/auth/domain/usecases/iniciar_sesion.dart` | Crear | Login usecase |
| `lib/features/auth/domain/usecases/registrar_usuario.dart` | Crear | Register usecase |
| `lib/features/auth/domain/usecases/cerrar_sesion.dart` | Crear | Logout usecase |

### Data layer
| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `lib/features/auth/data/models/usuario_dto.dart` | Crear | DTO con fromJson/toJson |
| `lib/features/auth/data/repositories/auth_repository_mock.dart` | Crear | Mock con delay 1.5s |

### Presentation layer
| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `lib/features/auth/presentation/screens/splash_screen.dart` | Crear | Logo + redirección |
| `lib/features/auth/presentation/screens/login_screen.dart` | Crear | Formulario login |
| `lib/features/auth/presentation/screens/registro_screen.dart` | Crear | Formulario registro |
| `lib/features/auth/presentation/screens/recuperar_screen.dart` | Crear | Formulario recuperar |
| `lib/features/auth/presentation/widgets/auth_header.dart` | Crear | Logo + título reutilizable |
| `lib/features/auth/presentation/providers/sesion_controller.dart` | Modificar | Agregar lógica real |
| `lib/core/router/app_router.dart` | Modificar | Reemplazar placeholders |

## 3. Flujo de pantallas

```
Splash (logo Ligerito, 2s)
  ├── Token válido → /home (cliente) o /panel/pedidos (negocio)
  └── Sin token → /login
        ├── Login OK → /home o /panel/pedidos (según rol)
        ├── Link "Regístrate" → /registro
        └── Link "¿Olvidaste?" → /recuperar
```

## 4. SesionController

```dart
@freezed
sealed class SesionState with _$SesionState {
  const factory SesionState.cargando() = SesionCargando;
  const factory SesionState.autenticado(Usuario usuario) = SesionAutenticada;
  const factory SesionState.noAutenticado() = SesionNoAutenticado;
}

@Riverpod(keepAlive: true)
class SesionController extends _$SesionController {
  @override
  Future<SesionState> build() async {
    // Fase 0: retorna noAutenticado
    // Fase 2: verifica token persistido
    return const SesionState.noAutenticado();
  }

  Future<void> iniciarSesion(String telefono, String password) async { ... }
  Future<void> registrar(String nombre, String telefono, String password) async { ... }
  Future<void> cerrarSesion() async { ... }
}
```

## 5. Mock Repository

- Delay simulado: 1.5s
- Credenciales válidas: cualquier teléfono 9 dígitos (empieza con 9) + password ≥ 6 chars
- Teléfonos 90/91/92 → rol `negocio` (para probar ambos flujos)
- Cualquier otro teléfono válido → rol `cliente`
- Error: retorna `Left(ServerFailure('Teléfono o contraseña incorrectos'))`

## 6. UI Login Screen

- Logo Ligerito (icono + nombre) via `AuthHeader`
- Título: "¡Qué bueno verte!" (l10n)
- Subtítulo: "Ingresa para pedir tu favorito"
- Campo teléfono con prefix "+51" (teclado numérico, 9 dígitos)
- Campo contraseña con toggle visibility
- Botón "Ingresar" (LigeritoButton primary, con loading)
- Link "¿No tienes cuenta? Regístrate" → /registro
- Link "¿Olvidaste tu contraseña?" → /recuperar
- Error: SnackBar "Teléfono o contraseña incorrectos"

## 7. UI Registro Screen

- AuthHeader con título "Crea tu cuenta"
- Campos: nombre, teléfono, email (opcional), contraseña
- Botón "Registrarme" (LigeritoButton primary, con loading)
- Link "¿Ya tienes cuenta? Inicia sesión" → /login
- Success: SnackBar "¡Listo! Ya eres parte de Ligerito" → redirige a /login

## 8. UI Recuperar Screen

- AuthHeader con título "Recuperar contraseña"
- Subtítulo: "Te enviaremos instrucciones a tu correo o SMS"
- Campo teléfono
- Botón "Enviar enlace" (LigeritoButton primary, con loading)
- Success: muestra mensaje de confirmación

## 9. UI Splash Screen

- Fondo: LigeritoColors.primary
- Icono centrado (Icons.bolt, tamaño 80, blanco)
- "Ligerito" (poppins 32, bold, blanco)
- Tagline: "Tu pedido, al toque." (inter 16, blanco 70% opacidad)
- CircularProgressIndicator blanco
- Verifica sesión → redirige

## 10. Validaciones

- Teléfono: `LigeritoValidators.telefono` (9 dígitos, empieza con 9)
- Contraseña: `LigeritoValidators.password` (mín 6 caracteres)
- Nombre: `LigeritoValidators.nombreObligatorio`

## 11. Tests

- Unit test para `IniciarSesion` usecase
- Unit test para `SesionController` (iniciarSesion, cerrarSesion)

## 12. Criterios de aceptación

- [ ] Splash verifica token; si válido redirige según rol, si no va a Login
- [ ] Login valida teléfono y contraseña antes de llamar API
- [ ] Error muestra mensaje "Teléfono o contraseña incorrectos"
- [ ] Registro asigna rol `cliente` por defecto
- [ ] Cerrar sesión limpia estado y redirige a /login
- [ ] Loading state deshabilita botones (anti doble-tap)
- [ ] Todos los strings usan l10n (AppLocalizations)

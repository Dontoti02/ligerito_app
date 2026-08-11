// lib/core/router/route_guards.dart
import 'package:ligerito/features/auth/domain/entities/usuario.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';

/// Rutas accesibles sin sesión.
const rutasPublicas = {'/login', '/registro', '/recuperar'};

/// Lógica pura de redirect (testeable, sin BuildContext).
/// Retorna la ruta destino si hay redirect, null si la navegación sigue.
String? routeGuard(SesionState sesion, String location) {
  if (location == '/splash') {
    return switch (sesion) {
      SesionCargando() => null,
      SesionAutenticada(usuario: final u) =>
        u.rol == RolUsuario.negocio ? '/panel/pedidos' : '/home',
      SesionNoAutenticada() => '/login',
    };
  }

  final esPublica = rutasPublicas.contains(location);

  return switch (sesion) {
    SesionCargando() => esPublica ? null : '/splash',
    SesionNoAutenticada() => esPublica ? null : '/login',
    SesionAutenticada(usuario: final u) => _guardAutenticado(u, location),
  };
}

String? _guardAutenticado(Usuario usuario, String location) {
  final enPanel = location.startsWith('/panel');
  final esNegocio = usuario.rol == RolUsuario.negocio;

  if (esNegocio && !enPanel) return '/panel/pedidos';
  if (!esNegocio && enPanel) return '/home';
  if (rutasPublicas.contains(location)) {
    return esNegocio ? '/panel/pedidos' : '/home';
  }
  return null;
}

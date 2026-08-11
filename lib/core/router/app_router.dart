// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/router/route_guards.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/screens/login_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/recuperar_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/registro_screen.dart';
import 'package:ligerito/features/auth/presentation/screens/splash_screen.dart';
import 'package:ligerito/features/carrito/presentation/screens/carrito_screen.dart';
import 'package:ligerito/features/carrito/presentation/screens/checkout_screen.dart';
import 'package:ligerito/features/catalogo/presentation/screens/home_screen.dart';
import 'package:ligerito/features/catalogo/presentation/screens/negocio_screen.dart';
import 'package:ligerito/features/pedidos/presentation/screens/direcciones_screen.dart';
import 'package:ligerito/features/pedidos/presentation/screens/historial_screen.dart';
import 'package:ligerito/features/pedidos/presentation/screens/pedido_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// ChangeNotifier con método público de refresh (notifyListeners es protected).
class _RouterRefresher extends ChangeNotifier {
  void refresh() => notifyListeners();
}

/// Re-notifica al router cuando cambia la sesión (para re-evaluar redirects).
@Riverpod(keepAlive: true)
ChangeNotifier routerRefresh(Ref ref) {
  final notifier = _RouterRefresher();
  ref.listen(sesionControllerProvider, (_, _) => notifier.refresh());
  ref.onDispose(notifier.dispose);
  return notifier;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: ref.watch(routerRefreshProvider),
    redirect: (context, state) {
      final sesion = ref
              .read(sesionControllerProvider)
              .valueOrNull ??
          const SesionState.cargando();
      return routeGuard(sesion, state.matchedLocation);
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/registro',
        builder: (context, state) => const RegistroScreen(),
      ),
      GoRoute(
        path: '/recuperar',
        builder: (context, state) => const RecuperarScreen(),
      ),
      // Shell cliente: Explorar / Pedidos / Perfil
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => ClienteShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/historial',
                builder: (context, state) => const HistorialScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                builder: (context, state) =>
                    const ModuloPlaceholderScreen(nombre: 'perfil'),
                routes: [
                  GoRoute(
                    path: 'direcciones',
                    builder: (context, state) => const DireccionesScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/negocio/:id',
        builder: (context, state) =>
            NegocioScreen(negocioId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/carrito',
        builder: (context, state) => const CarritoScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/pedido/:id',
        builder: (context, state) =>
            PedidoScreen(pedidoId: state.pathParameters['id']!),
      ),
      // Shell negocio: Pedidos / Menú / Dashboard
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => PanelShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/panel/pedidos',
                builder: (context, state) =>
                    const ModuloPlaceholderScreen(nombre: 'panel pedidos'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/panel/menu',
                builder: (context, state) =>
                    const ModuloPlaceholderScreen(nombre: 'panel menu'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/panel/dashboard',
                builder: (context, state) =>
                    const ModuloPlaceholderScreen(nombre: 'panel dashboard'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/panel/producto/nuevo',
        builder: (context, state) =>
            const ModuloPlaceholderScreen(nombre: 'producto nuevo'),
      ),
      GoRoute(
        path: '/panel/producto/:id/editar',
        builder: (context, state) =>
            ModuloPlaceholderScreen(nombre: 'producto editar ${state.pathParameters['id']}'),
      ),
    ],
  );
}

/// Pantalla temporal de Fase 0. Cada ola la reemplaza con la pantalla real
/// de su feature. Al cerrar el proyecto no queda ninguna en uso.
class ModuloPlaceholderScreen extends StatelessWidget {
  final String nombre;

  const ModuloPlaceholderScreen({super.key, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ligerito')),
      body: Center(child: Text('Módulo: $nombre')),
    );
  }
}

/// Shell con bottom navigation para el rol cliente.
class ClienteShell extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ClienteShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explorar'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Pedidos'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

/// Shell con bottom navigation para el rol negocio.
class PanelShell extends StatelessWidget {
  final StatefulNavigationShell shell;

  const PanelShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => shell.goBranch(
          index,
          initialLocation: index == shell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.inbox), label: 'Pedidos'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menú'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Dashboard'),
        ],
      ),
    );
  }
}

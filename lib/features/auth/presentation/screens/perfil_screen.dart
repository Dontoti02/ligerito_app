// lib/features/auth/presentation/screens/perfil_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';

class PerfilScreen extends ConsumerWidget {
  const PerfilScreen({super.key});

  String _iniciales(String nombre) {
    final partes = nombre.trim().split(' ');
    if (partes.length >= 2) {
      return (partes[0][0] + partes[1][0]).toUpperCase();
    }
    return nombre.length >= 2 ? nombre.substring(0, 2).toUpperCase() : nombre.toUpperCase();
  }

  void _mostrarDialogoCerrarSesion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Seguro que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(sesionControllerProvider.notifier).cerrarSesion();
            },
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: LigeritoColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sesion = ref.watch(sesionControllerProvider);
    final usuario = switch (sesion.valueOrNull) {
      SesionAutenticada(:final usuario) => usuario,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (usuario != null) ...[
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [LigeritoColors.primary, LigeritoColors.primaryDark],
                  ),
                ),
                child: Center(
                  child: Text(
                    _iniciales(usuario.nombre),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(usuario.nombre, style: LigeritoTextStyles.heading2),
              const SizedBox(height: 4),
              Text(usuario.telefono, style: LigeritoTextStyles.bodySecondary),
            ],
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: LigeritoColors.surface,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on, color: LigeritoColors.primary),
                    title: const Text('Mis direcciones'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/perfil/direcciones'),
                  ),
                  const Divider(height: 1, indent: 52),
                  ListTile(
                    leading: const Icon(Icons.person, color: LigeritoColors.primary),
                    title: const Text('Mis datos'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFFEBEE),
                  width: 1.5,
                ),
              ),
              child: TextButton(
                onPressed: () => _mostrarDialogoCerrarSesion(context, ref),
                child: const Text(
                  'Cerrar sesión',
                  style: TextStyle(color: LigeritoColors.error),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

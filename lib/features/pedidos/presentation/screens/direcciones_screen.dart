import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/presentation/providers/direcciones_controller.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/direccion_card.dart';

class DireccionesScreen extends ConsumerWidget {
  const DireccionesScreen({super.key});

  static const _piuraLat = -5.1783;
  static const _piuraLng = -80.6549;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(direccionesControllerProvider);
    final controller = ref.read(direccionesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Mis direcciones'),
      ),
      body: asyncState.when(
        data: (state) => state.when(
          cargando: () => const LigeritoListSkeleton(),
          loaded: (direcciones) {
            if (direcciones.isEmpty) {
              return const EmptyStateView(
                icon: Icons.location_on,
                title: 'No tienes direcciones guardadas',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: direcciones.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final direccion = direcciones[index];
                return DireccionCard(
                  direccion: direccion,
                  onEditar: () => _showDireccionDialog(
                    context: context,
                    controller: controller,
                    existing: direccion,
                  ),
                  onEliminar: () => controller.eliminar(direccion.id),
                );
              },
            );
          },
          error: (mensaje) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(mensaje, textAlign: TextAlign.center),
            ),
          ),
        ),
        loading: () => const LigeritoListSkeleton(),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(e.toString(), textAlign: TextAlign.center),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: LigeritoButton(
            label: '+ Nueva dirección',
            onPressed: () => _showDireccionDialog(
              context: context,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }

  void _showDireccionDialog({
    required BuildContext context,
    required DireccionesController controller,
    Direccion? existing,
  }) {
    final isEdit = existing != null;
    final etiquetaCtrl = TextEditingController(text: existing?.etiqueta ?? '');
    final direccionCtrl =
        TextEditingController(text: existing?.direccionTexto ?? '');
    final referenciaCtrl =
        TextEditingController(text: existing?.referencia ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Editar dirección' : 'Nueva dirección'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: etiquetaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Etiqueta',
                  hintText: 'Casa / Trabajo',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: direccionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Calle, número, urb.',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: referenciaCtrl,
                decoration: const InputDecoration(
                  labelText: 'Referencia (opcional)',
                  hintText: 'Frente al parque...',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final direccion = isEdit
                  ? existing.copyWith(
                      etiqueta: etiquetaCtrl.text,
                      direccionTexto: direccionCtrl.text,
                      referencia:
                          referenciaCtrl.text.isEmpty ? null : referenciaCtrl.text,
                    )
                  : Direccion(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      etiqueta: etiquetaCtrl.text,
                      direccionTexto: direccionCtrl.text,
                      lat: _piuraLat,
                      lng: _piuraLng,
                      referencia:
                          referenciaCtrl.text.isEmpty ? null : referenciaCtrl.text,
                    );
              if (isEdit) {
                controller.actualizar(direccion);
              } else {
                controller.crear(direccion);
              }
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Guardar',
              style: TextStyle(color: LigeritoColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

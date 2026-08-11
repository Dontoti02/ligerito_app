import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/pedidos/presentation/providers/pedidos_providers.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/estado_pedido_timeline.dart';
import 'package:url_launcher/url_launcher.dart';

class PedidoScreen extends ConsumerWidget {
  final String pedidoId;

  const PedidoScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidoAsync = ref.watch(pedidoDetalleProvider(pedidoId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Seguimiento'),
      ),
      body: pedidoAsync.when(
        loading: () => const Center(child: LigeritoListSkeleton(itemCount: 4, itemHeight: 48)),
        error: (_, _) => const Center(child: Text('Error al cargar el pedido')),
        data: (pedido) {
          if (pedido == null) {
            return const Center(child: Text('Pedido no encontrado'));
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: LigeritoColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delivery_dining,
                    color: LigeritoColors.primary,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text('¡Ya casi llega, ligerito!', style: LigeritoTextStyles.heading1, textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text('Pedido #$pedidoId', style: LigeritoTextStyles.bodySecondary),
                const SizedBox(height: 24),
                EstadoPedidoTimeline(estadoActual: pedido.estado),
                const Spacer(),
                LigeritoButton(
                  label: 'Contactar al negocio',
                  variant: LigeritoButtonVariant.outline,
                  onPressed: () => _contactarNegocio(context, pedidoId),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _contactarNegocio(BuildContext context, String id) async {
    final message = Uri.encodeComponent('Hola, consulto por mi pedido #$id en Ligerito');
    final uri = Uri.parse('https://wa.me/?text=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir WhatsApp')),
        );
      }
    }
  }
}

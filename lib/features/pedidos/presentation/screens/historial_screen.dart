import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/presentation/providers/pedidos_providers.dart';
import 'package:ligerito/features/pedidos/presentation/widgets/pedido_resumen_card.dart';

class HistorialScreen extends ConsumerWidget {
  const HistorialScreen({super.key});

  String _nombreNegocio(String negocioId) {
    return switch (negocioId) {
      'n1' => 'Pollería El Picanterón',
      'n2' => 'Farmacia San Pablo',
      'n3' => 'Mercado Central Piura',
      'n5' => 'Cevichería La Boca',
      _ => 'Negocio',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosAsync = ref.watch(misPedidosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis pedidos'),
        centerTitle: true,
      ),
      body: pedidosAsync.when(
        loading: () => const LigeritoListSkeleton(),
        error: (_, _) => const EmptyStateView(
          icon: Icons.error_outline,
          title: 'Error al cargar pedidos',
        ),
        data: (pedidos) {
          if (pedidos.isEmpty) {
            return const EmptyStateView(
              icon: Icons.receipt_long,
              title: 'Aún no tienes pedidos',
              subtitle: 'Tu primer pedido te espera, ligerito',
            );
          }

          final activos = pedidos
              .where((p) =>
                  p.estado != EstadoPedido.entregado &&
                  p.estado != EstadoPedido.cancelado)
              .toList();
          final entregados = pedidos
              .where((p) => p.estado == EstadoPedido.entregado)
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (activos.isNotEmpty) ...[
                Text(
                  'Pedidos activos',
                  style: LigeritoTextStyles.heading2.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...activos.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PedidoResumenCard(
                      pedido: p,
                      nombreNegocio: _nombreNegocio(p.negocioId),
                      onTap: () => context.push('/pedido/${p.id}'),
                    ),
                  ),
                ),
              ],
              if (entregados.isNotEmpty) ...[
                if (activos.isNotEmpty) const SizedBox(height: 16),
                Text(
                  'Historial',
                  style: LigeritoTextStyles.heading2.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...entregados.map(
                  (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: PedidoResumenCard(
                      pedido: p,
                      nombreNegocio: _nombreNegocio(p.negocioId),
                      onTap: () => context.push('/pedido/${p.id}'),
                      onRepetir: () {},
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

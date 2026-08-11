import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';
import 'package:ligerito/features/catalogo/domain/entities/producto.dart';
import 'package:ligerito/features/catalogo/presentation/providers/catalogo_providers.dart';
import 'package:ligerito/features/catalogo/presentation/widgets/producto_card.dart';

class NegocioScreen extends ConsumerWidget {
  final String negocioId;

  const NegocioScreen({super.key, required this.negocioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final negocioAsync = ref.watch(negocioProvider(negocioId));
    final productosAsync = ref.watch(productosNegocioProvider(negocioId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          negocioAsync.valueOrNull?.nombre ?? 'Negocio',
        ),
      ),
      body: negocioAsync.when(
        loading: () => const LigeritoListSkeleton(),
        error: (_, _) => const Center(child: Text('Error al cargar el negocio')),
        data: (negocio) {
          if (negocio == null) {
            return const Center(child: Text('Negocio no encontrado'));
          }
          return Column(
            children: [
              _NegocioHeader(negocio: negocio),
              const Divider(height: 1),
              Expanded(
                child: productosAsync.when(
                  loading: () => const LigeritoListSkeleton(),
                  error: (_, _) => const Center(child: Text('Error al cargar productos')),
                  data: (productos) => _buildProductos(productos),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductos(List<Producto> productos) {
    if (productos.isEmpty) {
      return const Center(
        child: Text(
          'Este negocio a\u00fan no tiene productos',
          style: TextStyle(color: LigeritoColors.textSecondary),
        ),
      );
    }

    final grouped = <String, List<Producto>>{};
    for (final p in productos) {
      final seccion = p.seccionMenu ?? 'Otros';
      (grouped[seccion] ??= []).add(p);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final entry = grouped.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                entry.key,
                style: LigeritoTextStyles.heading2.copyWith(fontSize: 14),
              ),
            ),
            ...entry.value.map(
              (producto) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ProductoCard(producto: producto),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class _NegocioHeader extends StatelessWidget {
  final dynamic negocio;

  const _NegocioHeader({required this.negocio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _StatusBadge(abierto: negocio.abierto),
          _InfoChip(
            icon: Icons.star_rounded,
            iconColor: LigeritoColors.warning,
            label: negocio.calificacion.toStringAsFixed(1),
          ),
          _InfoChip(
            icon: Icons.access_time_rounded,
            iconColor: LigeritoColors.textSecondary,
            label: '${negocio.tiempoEstimadoMin} min',
          ),
          _InfoChip(
            icon: Icons.delivery_dining_rounded,
            iconColor: LigeritoColors.textSecondary,
            label: 'Env\u00edo ${CurrencyFormatter.formatoPen((negocio.costoEnvioBase * 100).round())}',
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool abierto;

  const _StatusBadge({required this.abierto});

  @override
  Widget build(BuildContext context) {
    final color = abierto ? LigeritoColors.secondary : LigeritoColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        abierto ? 'Abierto' : 'Cerrado',
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 4),
        Text(label, style: LigeritoTextStyles.bodySecondary),
      ],
    );
  }
}

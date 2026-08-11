import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/features/carrito/presentation/providers/carrito_controller.dart';
import 'package:ligerito/features/carrito/presentation/widgets/cart_item_tile.dart';

class CarritoScreen extends ConsumerWidget {
  const CarritoScreen({super.key});

  static const int _envioCentavos = 300;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrito = ref.watch(carritoControllerProvider);
    final controller = ref.read(carritoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu pedido'),
      ),
      body: carrito.items.isEmpty
          ? const EmptyStateView(
              icon: Icons.shopping_cart,
              title: 'Tu carrito está vacío',
              subtitle: 'Agrega algo rico de un negocio',
            )
          : Column(
              children: [
                _NegocioHeader(negocioNombre: carrito.negocioNombre ?? 'Negocio'),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: carrito.items.length,
                    itemBuilder: (context, index) {
                      final item = carrito.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CartItemTile(
                          item: item,
                          onCantidadChanged: (cantidad) =>
                              controller.cambiarCantidad(item.producto.id, cantidad),
                        ),
                      );
                    },
                  ),
                ),
                _ResumenCard(
                  subtotalCentavos: controller.subtotalEnCentavos,
                  envioCentavos: _envioCentavos,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LigeritoButton(
                    label: 'Continuar',
                    onPressed: () => context.push('/checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _NegocioHeader extends StatelessWidget {
  final String negocioNombre;

  const _NegocioHeader({required this.negocioNombre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: LigeritoColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.store_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            negocioNombre,
            style: LigeritoTextStyles.heading2,
          ),
        ],
      ),
    );
  }
}

class _ResumenCard extends StatelessWidget {
  final int subtotalCentavos;
  final int envioCentavos;

  const _ResumenCard({
    required this.subtotalCentavos,
    required this.envioCentavos,
  });

  @override
  Widget build(BuildContext context) {
    final totalCentavos = subtotalCentavos + envioCentavos;

    return Card(
      color: LigeritoColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _ResumenRow(
              label: 'Subtotal',
              valor: CurrencyFormatter.formatoPen(subtotalCentavos),
            ),
            const SizedBox(height: 8),
            _ResumenRow(
              label: 'Envío',
              valor: CurrencyFormatter.formatoPen(envioCentavos),
            ),
            const Divider(height: 24),
            _ResumenRow(
              label: 'Total',
              valor: CurrencyFormatter.formatoPen(totalCentavos),
              esTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumenRow extends StatelessWidget {
  final String label;
  final String valor;
  final bool esTotal;

  const _ResumenRow({
    required this.label,
    required this.valor,
    this.esTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: esTotal
              ? GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: LigeritoColors.textPrimary,
                )
              : LigeritoTextStyles.body,
        ),
        Text(
          valor,
          style: esTotal ? LigeritoTextStyles.price : LigeritoTextStyles.body,
        ),
      ],
    );
  }
}

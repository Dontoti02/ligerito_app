import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';
import 'package:ligerito/features/carrito/presentation/providers/carrito_controller.dart';
import 'package:ligerito/features/carrito/presentation/widgets/payment_method_selector.dart';
import 'package:ligerito/features/pedidos/domain/entities/direccion.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';
import 'package:ligerito/features/pedidos/presentation/providers/direcciones_controller.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  Direccion? _direccionSeleccionada;
  MetodoPago? _metodoPagoSeleccionado;
  bool _confirmando = false;

  static const int _envioCentavos = 300;

  Future<void> _confirmarPedido() async {
    if (_direccionSeleccionada == null || _metodoPagoSeleccionado == null) return;
    setState(() => _confirmando = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    ref.read(carritoControllerProvider.notifier).vaciar();
    if (mounted) context.go('/historial');
  }

  @override
  Widget build(BuildContext context) {
    final direccionesAsync = ref.watch(direccionesControllerProvider);
    final subtotalCentavos =
        ref.read(carritoControllerProvider.notifier).subtotalEnCentavos;
    final totalCentavos = subtotalCentavos + _envioCentavos;
    final puedeConfirmar =
        _direccionSeleccionada != null && _metodoPagoSeleccionado != null && !_confirmando;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar pedido')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _SectionLabel(label: 'DIRECCIÓN DE ENTREGA'),
                  const SizedBox(height: 8),
                  direccionesAsync.when(
                    data: (state) => state.when(
                      cargando: () => const Center(child: CircularProgressIndicator()),
                      loaded: (dirs) => Column(
                        children: dirs
                            .map((d) => _DireccionCard(
                                  direccion: d,
                                  isSelected: _direccionSeleccionada?.id == d.id,
                                  onTap: () =>
                                      setState(() => _direccionSeleccionada = d),
                                ))
                            .toList(),
                      ),
                      error: (_) => const Center(child: Text('Error')),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, _) => const Center(child: Text('Error')),
                  ),
                  const SizedBox(height: 24),
                  _SectionLabel(label: 'MÉTODO DE PAGO'),
                  const SizedBox(height: 8),
                  PaymentMethodSelector(
                    selected: _metodoPagoSeleccionado,
                    onSelected: (m) => setState(() => _metodoPagoSeleccionado = m),
                  ),
                  const SizedBox(height: 24),
                  _ResumenCheckoutCard(
                    subtotalCentavos: subtotalCentavos,
                    envioCentavos: _envioCentavos,
                    totalCentavos: totalCentavos,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: LigeritoButton(
                label: 'Confirmar pedido',
                onPressed: puedeConfirmar ? _confirmarPedido : null,
                loading: _confirmando,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: LigeritoColors.textSecondary,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _DireccionCard extends StatelessWidget {
  final Direccion direccion;
  final bool isSelected;
  final VoidCallback onTap;

  const _DireccionCard({
    required this.direccion,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF5F5) : LigeritoColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? LigeritoColors.primary : const Color(0xFFE0E0E0),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? LigeritoColors.primary
                      : LigeritoColors.textSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.location_on,
                  color: isSelected
                      ? Colors.white
                      : LigeritoColors.textSecondary,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      direccion.etiqueta,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: LigeritoColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      direccion.direccionTexto,
                      style: LigeritoTextStyles.bodySecondary,
                    ),
                    if (direccion.referencia != null && direccion.referencia!.isNotEmpty)
                      Text(
                        direccion.referencia!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: LigeritoColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumenCheckoutCard extends StatelessWidget {
  final int subtotalCentavos;
  final int envioCentavos;
  final int totalCentavos;

  const _ResumenCheckoutCard({
    required this.subtotalCentavos,
    required this.envioCentavos,
    required this.totalCentavos,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LigeritoColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _Row(label: 'Subtotal', valor: CurrencyFormatter.formatoPen(subtotalCentavos)),
            const SizedBox(height: 8),
            _Row(label: 'Envío', valor: CurrencyFormatter.formatoPen(envioCentavos)),
            const Divider(height: 24),
            _Row(
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

class _Row extends StatelessWidget {
  final String label;
  final String valor;
  final bool esTotal;

  const _Row({required this.label, required this.valor, this.esTotal = false});

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

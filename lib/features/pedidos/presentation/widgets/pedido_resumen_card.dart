import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/core/utils/date_formatter.dart';
import 'package:ligerito/features/pedidos/domain/entities/estado_pedido.dart';
import 'package:ligerito/features/pedidos/domain/entities/pedido.dart';

class PedidoResumenCard extends StatelessWidget {
  final Pedido pedido;
  final String nombreNegocio;
  final VoidCallback? onTap;
  final VoidCallback? onRepetir;

  const PedidoResumenCard({
    super.key,
    required this.pedido,
    required this.nombreNegocio,
    this.onTap,
    this.onRepetir,
  });

  bool get _esActivo =>
      pedido.estado != EstadoPedido.entregado &&
      pedido.estado != EstadoPedido.cancelado;

  String get _shortId =>
      pedido.id.length > 6 ? pedido.id.substring(0, 6) : pedido.id;

  String get _iniciales {
    final parts = nombreNegocio.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return nombreNegocio.substring(0, 1).toUpperCase();
  }

  Color get _badgeColor {
    return switch (pedido.estado) {
      EstadoPedido.entregado => LigeritoColors.secondary,
      EstadoPedido.enCamino => LigeritoColors.info,
      EstadoPedido.preparando => Colors.orange,
      EstadoPedido.confirmado => const Color(0xFF7B1FA2),
      EstadoPedido.pendiente => LigeritoColors.textSecondary,
      EstadoPedido.cancelado => LigeritoColors.error,
    };
  }

  String get _badgeTexto {
    return switch (pedido.estado) {
      EstadoPedido.entregado => 'Entregado',
      EstadoPedido.enCamino => 'En camino',
      EstadoPedido.preparando => 'Preparando',
      EstadoPedido.confirmado => 'Confirmado',
      EstadoPedido.pendiente => 'Pendiente',
      EstadoPedido.cancelado => 'Cancelado',
    };
  }

  String get _itemsTexto =>
      pedido.items.map((i) => i.producto.nombre).join(', ');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: _esActivo
              ? const BorderSide(color: LigeritoColors.primary, width: 1.5)
              : BorderSide.none,
        ),
        color: LigeritoColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: LigeritoColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  _iniciales,
                  style: LigeritoTextStyles.body.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombreNegocio,
                      style: LigeritoTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Pedido #$_shortId · ${DateFormatter.tiempoTranscurrido(pedido.creadoEn)}',
                      style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _itemsTexto,
                      style: LigeritoTextStyles.bodySecondary.copyWith(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (pedido.estado == EstadoPedido.entregado && onRepetir != null) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: OutlinedButton(
                          onPressed: onRepetir,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: LigeritoColors.primary,
                            side: const BorderSide(color: LigeritoColors.primary),
                            minimumSize: const Size(0, 32),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          child: const Text('Repetir pedido'),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatoPen(pedido.totalEnCentavos),
                    style: LigeritoTextStyles.price,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _badgeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _badgeTexto,
                      style: LigeritoTextStyles.bodySecondary.copyWith(
                        color: _badgeColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

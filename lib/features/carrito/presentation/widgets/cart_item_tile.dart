import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/utils/currency_formatter.dart';
import 'package:ligerito/features/carrito/domain/entities/item_carrito.dart';

class CartItemTile extends StatelessWidget {
  final ItemCarrito item;
  final ValueChanged<int> onCantidadChanged;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onCantidadChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LigeritoColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.producto.nombre,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: LigeritoColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.notas != null && item.notas!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.notas!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: LigeritoColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    CurrencyFormatter.formatoPen(item.subtotalEnCentavos),
                    style: LigeritoTextStyles.price,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _CantidadCounter(
              cantidad: item.cantidad,
              onChanged: onCantidadChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _CantidadCounter extends StatelessWidget {
  final int cantidad;
  final ValueChanged<int> onChanged;

  const _CantidadCounter({
    required this.cantidad,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CounterButton(
          icon: Icons.remove,
          onTap: () => onChanged(cantidad - 1),
          isPrimary: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            cantidad.toString(),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: LigeritoColors.textPrimary,
            ),
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          onTap: () => onChanged(cantidad + 1),
          isPrimary: true,
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _CounterButton({
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPrimary ? LigeritoColors.primary : Colors.transparent,
          border: isPrimary
              ? null
              : Border.all(color: LigeritoColors.textSecondary, width: 1.5),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isPrimary ? Colors.white : LigeritoColors.textSecondary,
        ),
      ),
    );
  }
}

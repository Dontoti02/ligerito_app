import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/features/pedidos/domain/entities/metodo_pago.dart';

class PaymentMethodSelector extends StatelessWidget {
  final MetodoPago? selected;
  final ValueChanged<MetodoPago> onSelected;

  const PaymentMethodSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PaymentOption(
          metodo: MetodoPago.yape,
          isSelected: selected == MetodoPago.yape,
          onTap: () => onSelected(MetodoPago.yape),
        ),
        const SizedBox(height: 8),
        _PaymentOption(
          metodo: MetodoPago.plin,
          isSelected: selected == MetodoPago.plin,
          onTap: () => onSelected(MetodoPago.plin),
        ),
        const SizedBox(height: 8),
        _PaymentOption(
          metodo: MetodoPago.efectivo,
          isSelected: selected == MetodoPago.efectivo,
          onTap: () => onSelected(MetodoPago.efectivo),
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final MetodoPago metodo;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.metodo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (bgColor, borderColor, iconBg, iconChild) = _config;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: iconChild),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _titulo,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: LigeritoColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _subtitulo,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: LigeritoColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: LigeritoColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  String get _titulo {
    return switch (metodo) {
      MetodoPago.yape => 'Yape',
      MetodoPago.plin => 'Plin',
      MetodoPago.efectivo => 'Efectivo',
      MetodoPago.tarjeta => 'Tarjeta',
    };
  }

  String get _subtitulo {
    return switch (metodo) {
      MetodoPago.yape => 'Yapea al 949 123 456',
      MetodoPago.plin => 'Plin al 949 123 456',
      MetodoPago.efectivo => 'Paga al recibir',
      MetodoPago.tarjeta => '',
    };
  }

  (Color, Color, Color, Widget) get _config {
    const selectedBg = Color(0xFFFFF5F5);
    const selectedBorder = LigeritoColors.primary;
    const unselectedBorder = Color(0xFFE0E0E0);

    return switch (metodo) {
      MetodoPago.yape => (
          isSelected ? selectedBg : Colors.transparent,
          isSelected ? selectedBorder : unselectedBorder,
          const Color(0xFF6C3FC7),
          Text(
            'Y',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      MetodoPago.plin => (
          isSelected ? selectedBg : Colors.transparent,
          isSelected ? selectedBorder : unselectedBorder,
          const Color(0xFF00A859),
          Text(
            'P',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      MetodoPago.efectivo => (
          isSelected ? selectedBg : Colors.transparent,
          isSelected ? selectedBorder : unselectedBorder,
          const Color(0xFFE0E0E0),
          const Icon(
            Icons.money,
            color: LigeritoColors.textSecondary,
            size: 20,
          ),
        ),
      MetodoPago.tarjeta => (
          isSelected ? selectedBg : Colors.transparent,
          isSelected ? selectedBorder : unselectedBorder,
          const Color(0xFFE0E0E0),
          const Icon(Icons.credit_card, color: LigeritoColors.textSecondary, size: 20),
        ),
    };
  }
}

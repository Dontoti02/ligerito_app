// lib/core/widgets/ligerito_button.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';

enum LigeritoButtonVariant { primary, secondary, outline }

/// Botón estándar Ligerito con estado loading incorporado.
/// En loading deshabilita el tap (anti doble-tap = anti doble pedido).
class LigeritoButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final LigeritoButtonVariant variant;

  const LigeritoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.variant = LigeritoButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = loading ? null : onPressed;
    final child = loading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Text(label);

    final button = switch (variant) {
      LigeritoButtonVariant.primary => ElevatedButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
      LigeritoButtonVariant.secondary => ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: LigeritoColors.secondary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        ),
      LigeritoButtonVariant.outline => OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: LigeritoColors.primary,
            minimumSize: const Size.fromHeight(52),
            side: const BorderSide(color: LigeritoColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        ),
    };

    return Semantics(button: true, label: label, child: button);
  }
}

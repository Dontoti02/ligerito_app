// lib/core/widgets/error_view.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';

/// Vista de error estándar con botón Reintentar.
/// Toda pantalla renderiza Failure.message aquí, nunca strings técnicos.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                size: 64, color: LigeritoColors.error),
            const SizedBox(height: 16),
            Text(
              message,
              style: LigeritoTextStyles.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            LigeritoButton(label: 'Reintentar', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}

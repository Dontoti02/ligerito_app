// lib/core/widgets/empty_state_view.dart
import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/core/theme/text_styles.dart';

/// Vista de estado vacío con ícono/ilustración y texto.
class EmptyStateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: LigeritoColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              title,
              style: LigeritoTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: LigeritoTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

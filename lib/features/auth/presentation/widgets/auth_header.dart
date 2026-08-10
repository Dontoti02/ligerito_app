import 'package:flutter/material.dart';
import 'package:ligerito/core/constants/ligerito_colors.dart';
import 'package:ligerito/l10n/app_localizations.dart';

/// Header reutilizable para pantallas de auth: logo + título + subtítulo.
class AuthHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const AuthHeader({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 48),
        const Icon(
          Icons.bolt,
          size: 72,
          color: LigeritoColors.primary,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.appName,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: LigeritoColors.primary,
              ),
        ),
        const SizedBox(height: 32),
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        if (title != null) const SizedBox(height: 8),
        if (subtitle != null)
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: LigeritoColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}
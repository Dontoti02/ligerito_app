import 'package:flutter/material.dart';
import 'package:ligerito/core/theme/text_styles.dart';

/// Header reutilizable para pantallas de auth: logo + título + subtítulo.
class AuthHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const AuthHeader({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 48),
        Image.asset(
          'assets/logo.png',
          width: 200,
          height: 72,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 32),
        if (title != null)
          Text(
            title!,
            style: LigeritoTextStyles.heading1,
            textAlign: TextAlign.center,
          ),
        if (title != null) const SizedBox(height: 8),
        if (subtitle != null)
          Text(
            subtitle!,
            style: LigeritoTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ligerito/core/router/app_router.dart';
import 'package:ligerito/core/theme/ligerito_theme.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class LigeritoApp extends ConsumerWidget {
  const LigeritoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Ligerito',
      debugShowCheckedModeBanner: false,
      theme: LigeritoTheme.light,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es', 'PE'),
    );
  }
}

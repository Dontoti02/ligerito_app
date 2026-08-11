// lib/bootstrap.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ligerito/app.dart';

/// Inicialización de la app. Punto de enchufe de Crashlytics (Fase 2):
/// los dos handlers de error de abajo son donde se reportará.
Future<void> bootstrap() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('es_PE');
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    };
    runApp(const ProviderScope(child: LigeritoApp()));
  }, (error, stack) {
    debugPrint('Error no capturado: $error\n$stack');
  });
}

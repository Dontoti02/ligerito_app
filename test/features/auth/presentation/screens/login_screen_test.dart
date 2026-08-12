// test/features/auth/presentation/screens/login_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/features/auth/presentation/providers/sesion_controller.dart';
import 'package:ligerito/features/auth/presentation/screens/login_screen.dart';
import 'package:ligerito/l10n/app_localizations.dart';

class _FakeSesionController extends SesionController {
  @override
  Future<SesionState> build() async => const SesionState.noAutenticado();
}

Future<void> _pumpLogin(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        sesionControllerProvider.overrideWith(_FakeSesionController.new),
      ],
      child: MaterialApp(
        locale: const Locale('es', 'PE'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoginScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('muestra la nueva composición visual del login', (tester) async {
    await _pumpLogin(tester);

    expect(
      find.byKey(const ValueKey<String>('login-logo')),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.phone_outlined), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    expect(find.text('¡Qué bueno verte!'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
  });

  testWidgets('alterna la visibilidad de la contraseña', (tester) async {
    await _pumpLogin(tester);

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}

// test/core/widgets/error_view_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/error_view.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('muestra el mensaje y botón Reintentar', (tester) async {
    await tester.pumpWidget(
      wrap(ErrorView(
        message: 'Algo salió mal',
        onRetry: () {},
      )),
    );
    expect(find.text('Algo salió mal'), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('tap en Reintentar ejecuta onRetry', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      wrap(ErrorView(
        message: 'Error',
        onRetry: () => retried = true,
      )),
    );
    await tester.tap(find.text('Reintentar'));
    expect(retried, isTrue);
  });

  testWidgets('muestra icono de error', (tester) async {
    await tester.pumpWidget(
      wrap(ErrorView(
        message: 'Error',
        onRetry: () {},
      )),
    );
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });
}

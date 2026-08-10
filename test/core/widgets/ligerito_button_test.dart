// test/core/widgets/ligerito_button_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/ligerito_button.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('muestra el label y dispara onPressed', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      wrap(LigeritoButton(label: 'Confirmar', onPressed: () => taps++)),
    );
    expect(find.text('Confirmar'), findsOneWidget);
    await tester.tap(find.byType(LigeritoButton));
    expect(taps, 1);
  });

  testWidgets('en loading no dispara onPressed y muestra indicador',
      (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      wrap(LigeritoButton(
        label: 'Confirmar',
        loading: true,
        onPressed: () => taps++,
      )),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(LigeritoButton), warnIfMissed: false);
    expect(taps, 0);
  });

  testWidgets('deshabilitado cuando onPressed es null', (tester) async {
    await tester.pumpWidget(
      wrap(const LigeritoButton(label: 'X', onPressed: null)),
    );
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('variant outline usa OutlinedButton', (tester) async {
    await tester.pumpWidget(
      wrap(LigeritoButton(
        label: 'Secundario',
        variant: LigeritoButtonVariant.outline,
        onPressed: () {},
      )),
    );
    expect(find.byType(OutlinedButton), findsOneWidget);
  });
}

// test/core/widgets/ligerito_text_field_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/ligerito_text_field.dart';

void main() {
  Widget wrapForm(Widget child) => MaterialApp(
        home: Scaffold(
          body: Form(
            key: GlobalKey<FormState>(),
            child: child,
          ),
        ),
      );

  testWidgets('renderiza el label', (tester) async {
    await tester.pumpWidget(
      wrapForm(const LigeritoTextField(label: 'Teléfono')),
    );
    expect(find.text('Teléfono'), findsOneWidget);
  });

  testWidgets('muestra error de validación inline tras validate', (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: LigeritoTextField(
              label: 'Teléfono',
              validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
            ),
          ),
        ),
      ),
    );
    formKey.currentState!.validate();
    await tester.pump();
    expect(find.text('Requerido'), findsOneWidget);
  });

  testWidgets('obscureText oculta el texto', (tester) async {
    await tester.pumpWidget(
      wrapForm(const LigeritoTextField(label: 'Clave', obscureText: true)),
    );
    final field = tester.widget<EditableText>(find.byType(EditableText));
    expect(field.obscureText, isTrue);
  });
}

// test/core/widgets/empty_state_view_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/empty_state_view.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('muestra título e ícono', (tester) async {
    await tester.pumpWidget(
      wrap(const EmptyStateView(
        icon: Icons.shopping_cart,
        title: 'Carrito vacío',
      )),
    );
    expect(find.text('Carrito vacío'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });

  testWidgets('muestra subtitle cuando se proporciona', (tester) async {
    await tester.pumpWidget(
      wrap(const EmptyStateView(
        icon: Icons.inbox,
        title: 'Sin pedidos',
        subtitle: 'Aquí aparecerán tus pedidos',
      )),
    );
    expect(find.text('Sin pedidos'), findsOneWidget);
    expect(find.text('Aquí aparecerán tus pedidos'), findsOneWidget);
  });

  testWidgets('no muestra subtitle cuando es null', (tester) async {
    await tester.pumpWidget(
      wrap(const EmptyStateView(
        icon: Icons.inbox,
        title: 'Vacío',
      )),
    );
    expect(find.text('Vacío'), findsOneWidget);
    // Solo 1 Text widget (el título)
    expect(find.byType(Text), findsOneWidget);
  });
}

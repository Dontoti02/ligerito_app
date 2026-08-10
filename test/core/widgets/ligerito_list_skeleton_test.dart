// test/core/widgets/ligerito_list_skeleton_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligerito/core/widgets/loading_indicator.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('renderiza SkeletonBox items por defecto (5)', (tester) async {
    await tester.pumpWidget(wrap(const LigeritoListSkeleton()));
    expect(find.byType(SkeletonBox), findsNWidgets(5));
  });

  testWidgets('respeta itemCount personalizado', (tester) async {
    await tester.pumpWidget(wrap(const LigeritoListSkeleton(itemCount: 3)));
    expect(find.byType(SkeletonBox), findsNWidgets(3));
  });

  testWidgets('SkeletonBox tiene animación', (tester) async {
    await tester.pumpWidget(wrap(const SkeletonBox()));
    expect(find.byType(SkeletonBox), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byType(SkeletonBox), findsOneWidget);
  });
}

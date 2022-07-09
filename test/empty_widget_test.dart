import 'package:ecommerce/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Empty widgets renders text correctly',
      (WidgetTester tester) async {
    const String text = 'Empty';
    await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: EmptyWidget(text: text))));
    final textFinder = find.text(text);
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Empty widgets renders default text correctly',
      (WidgetTester tester) async {
    const String defaultText = "No products available";
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: EmptyWidget())));
    final textFinder = find.text(defaultText);
    expect(textFinder, findsOneWidget);
  });
}

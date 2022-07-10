import 'package:ecommerce/app/pages/admin/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Navigate to add product", (tester) async {
    await tester
        .pumpWidget(const ProviderScope(child: MaterialApp(home: AdminHome())));
    final possibleFAB = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(possibleFAB, findsOneWidget);

    await tester.tap(possibleFAB);

    await tester.pumpAndSettle();

    expect(find.text("Admin Home"), findsNothing);

    expect(find.text("Upload image"), findsOneWidget);
  });
}

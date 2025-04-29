import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/home_page.dart'; // suppose it's in lib/home_page.dart

void main() {
  testWidgets('HomePage displays text', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Hello Mommy Wissal ❤️'), findsOneWidget);
  });
}

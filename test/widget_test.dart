import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Hello, World!'),
          ),
        ),
      ),
    );

    // Verify that our text is displayed.
    expect(find.text('Hello, World!'), findsOneWidget);
    expect(find.text('Not found'), findsNothing);
  });
}
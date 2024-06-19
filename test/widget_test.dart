import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_project/main.dart';

void main() {
  testWidgets('CEP search test', (WidgetTester tester) async {
    //Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify the initial state of the app.
    expect(find.text('CEP'), findsOneWidget);
    expect(find.text('Consultar'), findsOneWidget);

    // Enter a CEP value into the TextField.
    await tester.enterText(find.byType(TextField), '01001000');

    // Tap the 'Consultar' button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Wait for the async call to complete.
    await tester
        .pump(const Duration(seconds: 2)); // Adjust the duration if needed

    // Verify that the result is displayed.
    expect(find.textContaining('CEP: 01001-000'), findsOneWidget);
  });
}

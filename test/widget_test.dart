// integration_test/app_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the activation page is displayed.
    expect(find.text('Welcome!'), findsOneWidget);

    // Simulate entering a phone number and agreeing to terms.
    await tester.enterText(find.byType(TextField).first, '1234567890');
    await tester.tap(find.byType(Checkbox));
    await tester.tap(find.text('Get Activation Code'));
    await tester.pumpAndSettle();

    // Verify that the code activation container is displayed.
    expect(find.text('Enter the activation code you received via SMS'), findsOneWidget);

    // Simulate entering the activation code.
    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Activate'));
    await tester.pumpAndSettle();

    // Verify that the factory app home page is displayed.
    expect(find.text('Factory 1 Status'), findsOneWidget);

    // Navigate to the profile page.
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Verify that the profile page is displayed.
    expect(find.text('Factory 1 Employees'), findsOneWidget);

    // Add a new employee.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'John Doe');
    await tester.enterText(find.byType(TextFormField).last, '0987654321');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that the new employee is added.
    expect(find.text('John Doe'), findsOneWidget);

    // Navigate to the settings page.
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    // Verify that the settings page is displayed.
    expect(find.text('Factory 1 Settings'), findsOneWidget);
  });
}

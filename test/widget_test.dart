import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Navigation between tabs', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that we are on the Home tab initially
    expect(find.text('Factory 1 Status'), findsOneWidget);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that we are on the Profile tab
    expect(find.text('Factory 1 Employees'), findsOneWidget);

    // Tap the Settings tab
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Verify that we are on the Settings tab
    expect(find.text('Factory 1 Settings').at(0), findsOneWidget);

    // Navigate back to the Home tab
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // Verify that we are back on the Home tab
    expect(find.text('Factory 1 Status'), findsOneWidget);
  });

  testWidgets('Add an employee in Profile tab', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Navigate to the Profile tab
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that we are on the Profile tab
    expect(find.text('Factory 1 Employees'), findsOneWidget);

    // Open the Add Employee dialog
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Fill in the employee details
    await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextFormField).at(1), '1234567890');

    // Submit the form
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that the new employee has been added
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
  });

  testWidgets('Update threshold in Settings tab', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Navigate to the Settings tab
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Verify that we are on the Settings tab
    expect(find.text('Factory 1 Settings').at(0), findsOneWidget);

    // Update the steam pressure threshold
    await tester.enterText(find.byType(TextFormField).at(0), '95');
    await tester.pumpAndSettle();

    // Verify that the steam pressure threshold has been updated
    expect(find.text('95'), findsOneWidget);
  });
}

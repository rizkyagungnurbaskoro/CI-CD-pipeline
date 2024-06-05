import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_1/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and navigates correctly', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify the home page loads with the expected text
    expect(find.text('Factory 1 Status'), findsOneWidget);

    // Tap the Profile tab
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify the profile page loads with the expected text
    expect(find.text('Factory 1 Employees'), findsOneWidget);

    // Tap the Settings tab
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    // Verify the settings page loads with the expected text
    expect(find.text('Factory 1 Settings'), findsOneWidget);

    // Navigate back to the Home tab
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();

    // Verify that we are back on the Home tab
    expect(find.text('Factory 1 Status'), findsOneWidget);
  });
}

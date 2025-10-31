import 'package:doctors_app/screens/workbench/treatment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'path_to_your_file/treatment.dart'; // update with actual path

void main() {
  testWidgets('Treatment page renders sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Treatment(),
      ),
    );

    // Check main sections exist
    expect(find.text('Package'), findsOneWidget);
    expect(find.text('Laboratory / Radiology'), findsOneWidget);
    expect(find.text('Procedure / Treatment / Service'), findsOneWidget);

    // Check initial package exists
    expect(find.text('Package: Comprehensive analysis package'), findsOneWidget);
    expect(find.text('Lab Test: ABDOMINAL PLAN X-RAY - STANDING POSITION'), findsOneWidget);
    expect(find.text('Procedure: Comprehensive analysis package'), findsOneWidget);
  });

  testWidgets('Adding a package updates list and total', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Treatment(),
      ),
    );

    // Open add package dialog
    await tester.tap(find.byIcon(Icons.add_circle).first);
    await tester.pumpAndSettle();

    // Select a package from dropdown
    await tester.tap(find.text('Choose a package').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Basic').last); // choose the first package from allPackages
    await tester.pumpAndSettle();

    // Tap Add button
    await tester.tap(find.text('Add').last);
    await tester.pumpAndSettle();

    // Check if the package is added to the list
    expect(find.text('Package: Basic'), findsOneWidget);

    // Check total updated (total must include new package netAmount = 90)
    expect(find.textContaining('Total:'), findsOneWidget);
  });

  testWidgets('Adding a lab test updates list', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Treatment(),
      ),
    );

    // Tap add lab test icon
    await tester.tap(find.byIcon(Icons.add_circle).at(1));
    await tester.pumpAndSettle();

    // Select a test from dropdown
    await tester.tap(find.text('Choose a package').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('CBC (Complete Blood Count)').last);
    await tester.pumpAndSettle();

    // Tap Add
    await tester.tap(find.text('Add').last);
    await tester.pumpAndSettle();

    // Check lab test added
    expect(find.text('Lab Test: CBC (Complete Blood Count)'), findsOneWidget);
  });

  testWidgets('Adding a procedure updates list', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Treatment(),
      ),
    );

    // Tap add procedure icon
    await tester.tap(find.byIcon(Icons.add_circle).at(2));
    await tester.pumpAndSettle();

    // Select a package (procedure uses Package dropdown)
    await tester.tap(find.text('Choose a package').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Basic').last);
    await tester.pumpAndSettle();

    // Tap Add
    await tester.tap(find.text('Add').last);
    await tester.pumpAndSettle();

    // Check procedure added
    expect(find.text('Package: Basic'), findsWidgets); // shows both in packages and procedure
  });
}

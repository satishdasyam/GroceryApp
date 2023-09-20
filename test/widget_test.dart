// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/main.dart';

void main() {
  testWidgets('Check for ListView and List details screen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ListView), findsOneWidget);

    //await tester.tap(find.byType(ListTile));
    for (final element in find.byType(ListTile).evaluate()) {
      await tester.tapAt(tester.getCenter(find.byWidget(element.widget)));
    }

    await tester.pumpAndSettle();
    expect(find.byType(Scaffold), findsOneWidget);
  });
}

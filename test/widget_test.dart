// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:holup/app/widgets/menu_item.dart';

import 'package:holup/main.dart';

void main() {
  testWidgets('Home widgets are rendered properly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HolupApp());

    // expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Menu items are rendered properly', (WidgetTester tester) async {
    await tester.pumpWidget(HolupApp());

    expect(find.byType(MenuItem), findsWidgets);

    expect(find.text('Ubytovanie'), findsOneWidget);
    expect(find.text('Kalendár'), findsOneWidget);

    expect(find.byType(Image), findsWidgets);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_copilot/main.dart';
import 'package:my_copilot/src/providers/theme_provider.dart';

void main() {
  testWidgets('App boots with persisted theme provider', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({'isDarkMode': false});
    final themeProvider = await ThemeProvider.initialize();

    await tester.pumpWidget(MyApp(themeProvider: themeProvider));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

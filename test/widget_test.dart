import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:m_link_project/core/theme/app_theme.dart';
import 'package:m_link_project/features/auth/role_selector_screen.dart';

void main() {
  testWidgets('Role selector renders student and merchant actions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RoleSelectorScreen(),
      ),
    );

    expect(find.text("I'm a Student"), findsOneWidget);
    expect(find.text("I'm a Merchant"), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/merchant_login_screen.dart';
import 'features/auth/role_selector_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String _initialRouteFromUrl() {
    final requestedRoute = Uri.base.queryParameters['route'];
    if (requestedRoute == 'login' || requestedRoute == '/login') {
      return '/login';
    }
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M-Link Project',
      theme: AppTheme.lightTheme,
      initialRoute: _initialRouteFromUrl(),
      routes: {
        '/': (context) => const RoleSelectorScreen(),
        '/login': (context) => const MerchantLoginScreen(),
      },
    );
  }
}

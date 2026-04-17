import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'features/merchant_dashboard/merchant_dashboard_screen.dart';
import 'features/auth/merchant_login_screen.dart';
import 'features/auth/role_selector_screen.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Firebase is not configured correctly for this platform.\n\n'
                    'Run `flutterfire configure` and add platform config files.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }

        return const MyApp();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String _initialRouteFromUrl() {
    final uri = Uri.base;
    final requestedRoute = uri.queryParameters['route'] ?? uri.path;
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
      home: _AuthAwareHome(
        initialRouteFromUrl: _initialRouteFromUrl(),
      ),
      routes: {
        '/login': (context) => const MerchantLoginScreen(),
        '/merchant-dashboard': (context) => const MerchantDashboardScreen(),
      },
    );
  }
}

class _AuthAwareHome extends StatelessWidget {
  final String initialRouteFromUrl;

  const _AuthAwareHome({required this.initialRouteFromUrl});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (initialRouteFromUrl == '/login') {
          return const MerchantLoginScreen();
        }

        if (snapshot.hasData) {
          return const MerchantDashboardScreen();
        }

        return const RoleSelectorScreen();
      },
    );
  }
}

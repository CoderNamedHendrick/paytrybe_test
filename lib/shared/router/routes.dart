import 'package:flutter/material.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/presentation/auth/pages/auth_home.dart';
import 'package:paytrybe_test/presentation/auth/pages/create_account.dart';
import 'package:paytrybe_test/presentation/main/home_main.dart';
import 'package:paytrybe_test/presentation/splash_screen/splash_screen.dart';

class AppRouter {
  const AppRouter();

  static final rootNavigator = GlobalKey<NavigatorState>();

  Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AuthHome.route:
        return MaterialPageRoute(builder: (_) => const AuthHome());

      case CreateAccount.route:
        final PhoneNumber phone =
            (settings.arguments as Map<String, dynamic>? ?? {})['phone'] ??
                PhoneNumber('');
        return MaterialPageRoute(builder: (_) => CreateAccount(phone: phone));

      case HomeMain.route:
        return MaterialPageRoute(builder: (_) => const HomeMain());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No Route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}

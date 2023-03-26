import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/presentation/splash_screen/splash_screen.dart';
import 'package:paytrybe_test/shared/router/routes.dart';
import 'package:paytrybe_test/shared/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'PayTrybe',
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.rootNavigator,
        onGenerateRoute: _appRouter.generateRoutes,
        initialRoute: SplashScreen.route,
        theme: AppTheme(context).lightTheme,
        darkTheme: AppTheme(context).darkTheme,
      ),
    );
  }
}

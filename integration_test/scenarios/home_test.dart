import 'package:flutter_test/flutter_test.dart';
import 'package:paytrybe_test/keys.dart';

import '../common.dart';
import '../robots/home_robot.dart';
import '../robots/sign_up_robot.dart';
import 'package:paytrybe_test/main.dart' as app;

void main() {
  SignUpRobot signUpRobot;
  HomeRobot homeRobot;

  trybeTester('Enter app and change screens', (widgetTester) async {
    app.main();

    signUpRobot = SignUpRobot(widgetTester);
    homeRobot = HomeRobot(widgetTester);

    // Login
    await _signIn(widgetTester, signUpRobot);

    await homeRobot.pressNavButton(NavOption.cards);
    expect(find.byKey(NavOption.cards.pageKey), findsOneWidget);

    await homeRobot.pressNavButton(NavOption.transactions);
    expect(find.byKey(NavOption.transactions.pageKey), findsOneWidget);

    await homeRobot.pressNavButton(NavOption.settings);
    expect(find.byKey(NavOption.settings.pageKey), findsOneWidget);

    await homeRobot.pressNavButton(NavOption.home);
    expect(find.byKey(NavOption.home.pageKey), findsOneWidget);
  });
}

Future<void> _signIn(WidgetTester widgetTester, SignUpRobot signUpRobot) async {
  await widgetTester.pumpAndSettle();
  final splashLogo = find.byKey(AKey.splashScreenLogo);
  expect(splashLogo, findsOneWidget);
  await widgetTester.pumpAndSettle(const Duration(seconds: 3));
  expect(find.text('Get Started'), findsOneWidget);
  await widgetTester.progressAnimationSafely();
  await signUpRobot.pressDropdown();
  await signUpRobot.pressNigeria();
  await signUpRobot.enterPhone('9056153649');
  await signUpRobot.pressGetStartedContinue();
  await widgetTester.progressAnimationSafely();
  await signUpRobot.enterOtp('333333');
  await signUpRobot.pressVerifyPhoneContinue();
  await signUpRobot.enterFirstAndLastName('John Doe');
  await signUpRobot.enterEmail('jonnyboy@gmail.com');
  await signUpRobot.enterPassword('Password');
  await signUpRobot.tapCreateAccountContinue();
  expect(find.byKey(AKey.homePage), findsOneWidget);
}

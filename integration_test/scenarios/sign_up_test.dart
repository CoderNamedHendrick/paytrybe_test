import 'package:flutter_test/flutter_test.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/main.dart' as app;
import 'package:paytrybe_test/shared/constants.dart';

import '../common.dart';
import '../robots/sign_up_robot.dart';

void main() {
  SignUpRobot signUpRobot;
  trybeTester('Sign Up Test', (widgetTester) async {
    app.main();
    signUpRobot = SignUpRobot(widgetTester);

    await widgetTester.pumpAndSettle();
    final splashLogo = find.byKey(AKey.splashScreenLogo);
    expect(splashLogo, findsOneWidget);

    await widgetTester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Get Started'), findsOneWidget);

    await widgetTester.progressAnimationSafely();

    await signUpRobot.pressDropdown();
    await signUpRobot.pressNigeria();

    await signUpRobot.pressGetStartedContinue();
    await widgetTester.progressAnimationSafely();
    expect(find.text('Phone Number cannot be empty'), findsWidgets);

    await signUpRobot.enterPhone('90561536');
    await signUpRobot.pressGetStartedContinue();
    await widgetTester.progressAnimationSafely();
    expect(find.text('Please enter a valid phone number'), findsWidgets);

    await signUpRobot.enterPhone('9056153649');
    expect(find.text('Please enter a valid phone number'), findsNothing);
    await signUpRobot.pressGetStartedContinue();

    await widgetTester.progressAnimationSafely();

    await signUpRobot.enterOtp('111111');
    await signUpRobot.pressVerifyPhoneContinue(andSettle: false);
    await widgetTester.progressAnimationSafely();
    expect(
        find.text(
            'Invalid OTP(failure test), input ${Constants.validOTP} to pass'),
        findsOneWidget);
    await widgetTester.progressAnimationSafely();

    await signUpRobot.enterOtp('333333');
    await signUpRobot.pressVerifyPhoneContinue();

    await signUpRobot.enterFirstAndLastName('John Doe');
    await signUpRobot.enterEmail('jonnyboy@gmail.com');
    await signUpRobot.enterPassword('Password');

    await signUpRobot.tapCreateAccountContinue();

    expect(find.byKey(AKey.homePage), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:paytrybe_test/keys.dart';

import '../common.dart';

class SignUpRobot {
  const SignUpRobot(this.tester);

  final WidgetTester tester;

  Future<void> pressDropdown() async {
    final btn = find.byKey(AKey.dropdownBtn);
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> pressNigeria() async {
    final btn = find.text('Nigeria');
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> enterPhone(String input) async {
    final field = find.byKey(AKey.phoneNumber);
    expect(field, findsOneWidget);

    await tester.enterText(field, input);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> pressGetStartedContinue() async {
    final btn = find.byKey(AKey.getStartedContinueBtn);
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pump();
    await Future.delayed(waitDuration);
  }

  Future<void> enterOtp(String input) async {
    final field = find.byKey(AKey.otpField);
    expect(field, findsOneWidget);

    await tester.enterText(field, input);
    await tester.pump();
    await Future.delayed(waitDuration);
  }

  Future<void> pressVerifyPhoneContinue({bool andSettle = true}) async {
    final btn = find.byKey(AKey.otpContinueBtn);
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    if (andSettle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
    await Future.delayed(waitDuration);
  }

  Future<void> enterFirstAndLastName(String input) async {
    final field = find.byKey(AKey.firstAndLastName);
    expect(field, findsOneWidget);

    await tester.enterText(field, input);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> enterEmail(String input) async {
    final field = find.byKey(AKey.emailAddress);
    expect(field, findsOneWidget);

    await tester.enterText(field, input);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> enterPassword(String input) async {
    final field = find.byKey(AKey.password);
    expect(field, findsOneWidget);

    await tester.enterText(field, input);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> tapCreateAccountContinue() async {
    final btn = find.byKey(AKey.createAccountContinueBtn);
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }

  Future<void> tapPasswordVisibility() async {
    final btn = find.byKey(AKey.passwordVisibleBtn);
    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }
}

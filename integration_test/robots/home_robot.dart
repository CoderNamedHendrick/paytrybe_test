import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paytrybe_test/keys.dart';

import '../common.dart';

class HomeRobot {
  final WidgetTester tester;

  const HomeRobot(this.tester);

  Future<void> pressNavButton(NavOption option) async {
    final btn = find.byKey(option.buttonKey);

    expect(btn, findsOneWidget);

    await tester.tap(btn);
    await tester.pumpAndSettle();
    await Future.delayed(waitDuration);
  }
}

enum NavOption {
  home(AKey.homeBtn, AKey.homePage),
  transactions(AKey.transactionBtn, AKey.transactionsPage),
  cards(AKey.cardsBtn, AKey.cardsPage),
  settings(AKey.settingsBtn, AKey.settingsPage);

  const NavOption(this.buttonKey, this.pageKey);

  final Key buttonKey;
  final Key pageKey;
}

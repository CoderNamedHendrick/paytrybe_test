// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/presentation/main/cards/pages/cards.dart';
import 'package:paytrybe_test/presentation/main/home/pages/home.dart';
import 'package:paytrybe_test/presentation/main/settings/pages/settings.dart';
import 'package:paytrybe_test/presentation/main/transactions/pages/transactions.dart';
import 'package:paytrybe_test/shared/theme/app_texts.dart';
import 'package:paytrybe_test/shared/theme/assets_extension.dart';
import 'package:paytrybe_test/shared/widgets/animated_indexed_stack.dart';

class HomeMain extends ConsumerWidget {
  static const route = '/home-main';

  const HomeMain({Key? key}) : super(key: key);

  static const _pages = [
    HomePage(key: AKey.homePage),
    TransactionsPage(key: AKey.transactionsPage),
    CardsPage(key: AKey.cardsPage),
    SettingsPage(key: AKey.settingsPage),
  ];

  @override
  Widget build(BuildContext context, ref) {
    int currentIndex = ref.watch(_bottomNavStateProvider);
    return Scaffold(
      body: AnimatedIndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        selectedLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
        unselectedLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: const Color(0xFF8E98A8),
              fontWeight: FontWeight.w500,
            ),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: const Color(0xFF8E98A8),
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (page) {
          ref.read(_bottomNavStateProvider.notifier).state = page;
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'home_icon'.svg,
              key: AKey.homeBtn,
              color: currentIndex == 0
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFF8E98A8),
            ),
            label: ButtonTitle.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'transactions_icon'.svg,
              key: AKey.transactionBtn,
              color: currentIndex == 1
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFF8E98A8),
            ),
            label: ButtonTitle.transactions,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('cards_icon'.svg, key: AKey.cardsBtn),
            activeIcon:
                SvgPicture.asset('cards_icon_active'.svg, key: AKey.cardsBtn),
            label: ButtonTitle.cards,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'settings_icon'.svg,
              key: AKey.settingsBtn,
              color: currentIndex == 3
                  ? Theme.of(context).colorScheme.primary
                  : const Color(0xFF8E98A8),
            ),
            label: ButtonTitle.settings,
          ),
        ],
      ),
    );
  }
}

final _bottomNavStateProvider = StateProvider.autoDispose<int>((ref) => 0);

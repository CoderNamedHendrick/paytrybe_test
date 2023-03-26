import 'package:flutter/cupertino.dart';

typedef AKey = Keys;

class Keys {
  const Keys();

  static const splashScreenLogo = Key('splash-screen-logo');
  static const dropdownBtn = Key('countries-dropdown-btn');
  static const getStartedContinueBtn = Key('get-started-continue-btn');
  static const phoneNumber = Key('phone-number');

  // verify phone number
  static const otpField = Key('otp-field');
  static const otpContinueBtn = Key('otp-continue-btn');

  // email and password
  static const firstAndLastName = Key('first-and-last-name');
  static const emailAddress = Key('email-address');
  static const password = Key('password');
  static const createAccountContinueBtn = Key('create-account-continue-btn');
  static const passwordVisibleBtn = Key('password-visible-btn');

  // home
  static const homeBtn = Key('home-btn');
  static const transactionBtn = Key('transaction-btn');
  static const cardsBtn = Key('cards-btn');
  static const settingsBtn = Key('settings-btn');

  static const homePage = Key('home-page');
  static const transactionsPage = Key('transactions-page');
  static const cardsPage = Key('cards-page');
  static const settingsPage = Key('settings-page');
}

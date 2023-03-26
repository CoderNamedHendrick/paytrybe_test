import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paytrybe_test/applicatioin/core/trybe_view_model.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/infrastructure/dtos/country_code.dart';
import 'package:paytrybe_test/presentation/auth/pages/create_account.dart';
import 'auth_home_vm.dart';

final authHomeStateNotifierProvider = StateNotifierProvider //
    .autoDispose<AuthHomeNotifier, AuthHomeViewModel>(
        (ref) => AuthHomeNotifier());

class AuthHomeNotifier extends StateNotifier<AuthHomeViewModel> {
  AuthHomeNotifier() : super(AuthHomeViewModel.inital());

  void phoneOnChanged(String value) => state = state.copyWith(
        phoneNumber: PhoneNumber(value),
      );

  void countryCodeOnChanged(CountryCode code,
      [TextEditingController? controller]) {
    if (code == state.countryCode) return;
    PhoneNumber.countryCode = code.countryCode;
    state = state.copyWith(countryCode: code);
    controller?.clear();
  }

  void continueOnTap(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (state.phoneNumber.isValid) {
      await launch([state], (model) async {
        state =
            model.assign(state.copyWith(viewState: ViewState.loading)).state;

        await Future.delayed(const Duration(seconds: 2));

        state =
            model.assign(state.copyWith(viewState: ViewState.success)).state;

        if (!mounted) return;
        Navigator.of(context).pushNamed(
          CreateAccount.route,
          arguments: {'phone': state.phoneNumber},
        );
      });
      return;
    }

    state = state.copyWith(showFormErrors: true);
  }
}

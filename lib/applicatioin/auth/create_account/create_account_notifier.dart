import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/applicatioin/auth/create_account/create_account_vm.dart';
import 'package:paytrybe_test/applicatioin/core/trybe_view_model.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/domain/core/exceptions.dart';
import 'package:paytrybe_test/shared/constants.dart';

import '../../../presentation/main/home_main.dart';

final createAccountNotifierProvider = StateNotifierProvider //
    .autoDispose<CreateAccountNotifier, CreateAccountViewModel>(
        (ref) => CreateAccountNotifier());

class CreateAccountNotifier extends StateNotifier<CreateAccountViewModel> {
  CreateAccountNotifier() : super(CreateAccountViewModel.initial());

  void initializePhone(PhoneNumber phoneNumber) => state = state.copyWith(
        createAccountEntity: state.createAccountEntity.copyWith(
          phoneNumber: phoneNumber,
        ),
      );

  void backOnTap(BuildContext context) => state.page == 0
      ? Navigator.of(context).pop()
      : state = state.copyWith(page: state.page - 1, showFormErrors: false);

  void pageOneOnTap(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (state.createAccountEntity.oneTimePassword.isValid) {
      await launch([state], (model) async {
        state =
            model.assign(state.copyWith(viewState: ViewState.loading)).state;

        await Future.delayed(const Duration(seconds: 2));

        if (state.createAccountEntity.oneTimePassword.getOrCrash() !=
            Constants.validOTP) {
          state = model
              .assign(state.copyWith(
                  viewState: ViewState.error,
                  error: const MessageException(
                    'Invalid OTP(failure test), input ${Constants.validOTP} to pass',
                  )))
              .state;
        } else {
          state = model
              .assign(
                state.copyWith(
                    viewState: ViewState.success, page: state.page + 1),
              )
              .state;
          state = state.copyWith(showFormErrors: false);
        }
      });
      return;
    }

    state = state.copyWith(showFormErrors: true);
  }

  Future<void> resendOTP(BuildContext context) async {
    FocusScope.of(context).unfocus();
    launch([state], (model) async {
      state = model.assign(state.copyWith(viewState: ViewState.loading)).state;

      await Future.delayed(const Duration(seconds: 2));

      state = model
          .assign(state.copyWith(
              viewState: ViewState.success,
              showFormErrors: false,
              createAccountEntity: state.createAccountEntity
                  .copyWith(oneTimePassword: OneTimePassword(''))))
          .state;
    });
  }

  void pageTwoOnTap(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (state.createAccountEntity.failureOrNull == null) {
      await launch([state], (model) async {
        state =
            model.assign(state.copyWith(viewState: ViewState.loading)).state;

        await Future.delayed(const Duration(seconds: 2));

        state =
            model.assign(state.copyWith(viewState: ViewState.success)).state;

        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeMain.route,
          (route) => false,
        );
      });
      return;
    }

    state = state.copyWith(showFormErrors: true);
  }

  void oneTimePasswordOnChanged(String input) => state = state.copyWith(
        createAccountEntity: state.createAccountEntity.copyWith(
          oneTimePassword: OneTimePassword(input),
        ),
      );

  void firstAndLastNameOnChanged(String input) => state = state.copyWith(
        createAccountEntity: state.createAccountEntity.copyWith(
          firstAndLastNames: FirstAndLastNames(input),
        ),
      );

  void emailAddressOnChanged(String input) => state = state.copyWith(
        createAccountEntity: state.createAccountEntity.copyWith(
          emailAddress: EmailAddress(input),
        ),
      );

  void passwordOnChanged(String input) => state = state.copyWith(
        createAccountEntity: state.createAccountEntity.copyWith(
          password: Password(input),
        ),
      );

  void passwordVisibilityOnChanged() => state = state.copyWith(
        obscurePassword: !state.obscurePassword,
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/applicatioin/auth/create_account/create_account_notifier.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/presentation/auth/widgets/auth_widgets.dart';
import 'package:paytrybe_test/shared/theme/app_texts.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/utility.dart';

import '../../../applicatioin/core/trybe_view_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/widgets/widgets.dart';

class VerifyPhoneNumberPage extends ConsumerWidget {
  const VerifyPhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(
            createAccountNotifierProvider.select((value) => value.viewState)) ==
        ViewState.loading;
    final phone = ref.watch(createAccountNotifierProvider
        .select((value) => value.createAccountEntity.phoneNumber));
    return AbsorbPointer(
      absorbing: isLoading,
      child: Form(
        autovalidateMode: ref.watch(createAccountNotifierProvider
                .select((value) => value.showFormErrors))
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.verifyPhoneNumberTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            SizedBox(height: Constants.largeGridSpace.rh),
            Text(
              '${AppTexts.verifyPhoneNumberSubtitle} ${PhoneNumber.countryCode.internationalCode} ${phone.getOr() ?? 'N\\A'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            SizedBox(height: Constants.smallGridSpace.rh),
            OTPTextField(
              key: AKey.otpField,
              onChanged: ref
                  .read(createAccountNotifierProvider.notifier)
                  .oneTimePasswordOnChanged,
              validation: (_) => ref
                  .read(createAccountNotifierProvider
                      .select((value) => value.createAccountEntity))
                  .oneTimePassword
                  .failureOrNever
                  .fold((left) => left.failureMessage, (_) => null),
            ),
            SizedBox(height: Constants.largeGridSpace.rh + 10),
            Center(
              child: ResendOTP(
                resendOTPOnTap: () async {
                  await Future.delayed(const Duration(seconds: 2));
                },
              ),
            ),
            const Spacer(),
            TrybePrimaryButton(
              key: AKey.otpContinueBtn,
              isLoading: isLoading,
              onPressed: () => ref
                  .read(createAccountNotifierProvider.notifier)
                  .pageOneOnTap(context),
              label: ButtonTitle.continueText,
            ),
          ],
        ),
      ),
    );
  }
}

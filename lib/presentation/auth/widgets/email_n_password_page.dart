import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/applicatioin/auth/create_account/create_account_notifier.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/presentation/auth/widgets/disclaimer_text.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/text_field.dart';

import '../../../applicatioin/core/trybe_view_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/theme/app_texts.dart';
import '../../../shared/widgets/buttons.dart';

class EmailAndPasswordPage extends ConsumerWidget {
  const EmailAndPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isLoading = ref.watch(
            createAccountNotifierProvider.select((value) => value.viewState)) ==
        ViewState.loading;

    return AbsorbPointer(
      absorbing: isLoading,
      child: Form(
        autovalidateMode: ref.watch(createAccountNotifierProvider
                .select((value) => value.showFormErrors))
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: FocusTraversalGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.emailAndPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              SizedBox(height: Constants.smallHorizontalGrid.rh),
              Text(
                AppTexts.emailAndPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              SizedBox(height: Constants.mediumGridSpace.rh),
              TrybeTextField(
                key: AKey.firstAndLastName,
                isLabelInTextField: true,
                label: TextFieldTitle.firstAndLastName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                onChanged: ref
                    .read(createAccountNotifierProvider.notifier)
                    .firstAndLastNameOnChanged,
                downArrowAction: FocusScope.of(context).nextFocus,
                validation: (_) => ref
                    .read(createAccountNotifierProvider
                        .select((value) => value.createAccountEntity))
                    .firstAndLastNames
                    .failureOrNever
                    .fold((left) => left.failureMessage, (_) => null),
              ),
              SizedBox(height: Constants.xSmallGridSpace.rh),
              TrybeTextField(
                key: AKey.emailAddress,
                isLabelInTextField: true,
                label: TextFieldTitle.emailAddress,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: ref
                    .read(createAccountNotifierProvider.notifier)
                    .emailAddressOnChanged,
                downArrowAction: FocusScope.of(context).nextFocus,
                upArrowAction: FocusScope.of(context).previousFocus,
                validation: (_) => ref
                    .read(createAccountNotifierProvider
                        .select((value) => value.createAccountEntity))
                    .emailAddress
                    .failureOrNever
                    .fold((left) => left.failureMessage, (_) => null),
              ),
              SizedBox(height: Constants.xSmallGridSpace.rh),
              TrybeTextField(
                key: AKey.password,
                isLabelInTextField: true,
                label: TextFieldTitle.password,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: ref.watch(createAccountNotifierProvider
                    .select((value) => value.obscurePassword)),
                onChanged: ref
                    .read(createAccountNotifierProvider.notifier)
                    .passwordOnChanged,
                downArrowAction: FocusScope.of(context).unfocus,
                upArrowAction: FocusScope.of(context).previousFocus,
                validation: (_) => ref
                    .read(createAccountNotifierProvider
                        .select((value) => value.createAccountEntity))
                    .password
                    .failureOrNever
                    .fold((left) => left.failureMessage, (_) => null),
                suffix: IconButton(
                  key: AKey.passwordVisibleBtn,
                  onPressed: ref
                      .read(createAccountNotifierProvider.notifier)
                      .passwordVisibilityOnChanged,
                  icon: ref.watch(createAccountNotifierProvider
                          .select((value) => value.obscurePassword))
                      ? Icon(
                          Icons.remove_red_eye_outlined,
                          color: Theme.of(context).colorScheme.onBackground,
                        )
                      : Icon(
                          Icons.remove_red_eye,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
              ),
              SizedBox(height: Constants.largeGridSpace.rh + 10),
              const DisclaimerText(),
              const Spacer(),
              TrybePrimaryButton(
                key: AKey.createAccountContinueBtn,
                isLoading: isLoading,
                onPressed: () => ref
                    .read(createAccountNotifierProvider.notifier)
                    .pageTwoOnTap(context),
                label: ButtonTitle.continueText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

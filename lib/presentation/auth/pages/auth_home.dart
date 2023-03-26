import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/applicatioin/auth/auth_home/auth_home_notifier.dart';
import 'package:paytrybe_test/applicatioin/core/trybe_view_model.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/utility.dart';
import 'package:paytrybe_test/shared/widgets/widgets.dart';

import '../../../shared/theme/app_texts.dart';
import '../widgets/auth_widgets.dart';

class AuthHome extends ConsumerStatefulWidget {
  static const route = '/get-started';

  const AuthHome({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthHome> createState() => _AuthHomeState();
}

class _AuthHomeState extends ConsumerState<AuthHome> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countryCode = ref.watch(
        authHomeStateNotifierProvider.select((value) => value.countryCode));
    final isLoading = ref.watch(
            authHomeStateNotifierProvider.select((value) => value.viewState)) ==
        ViewState.loading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Form(
            autovalidateMode: ref.watch(authHomeStateNotifierProvider
                    .select((value) => value.showFormErrors))
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsets.only(
                left: Constants.horizontalPadding.rw,
                right: Constants.horizontalPadding.rw,
                top: Constants.xxLargeGridSpace.rh,
                bottom: Constants.largeGridSpace.rh,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get Started',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  SizedBox(height: Constants.mediumGridSpace.rh),
                  CountryCodeTextField(
                    key: AKey.phoneNumber,
                    controller: controller,
                    labelText: 'Phone Number',
                    phoneFormatter: PhoneInputFormatter(
                      defaultCountryCode: countryCode.countryCode,
                      allowEndlessPhone: false,
                    ),
                    countryCode:
                        '${PhoneNumber.countryCode.internationalCode} ',
                    countryLogoPath: countryCode.countryLogo,
                    onEditingComplete: FocusScope.of(context).unfocus,
                    onChanged: ref
                        .read(authHomeStateNotifierProvider.notifier)
                        .phoneOnChanged,
                    changeCountryOnTap: () async {
                      final code = await showSelectCountryBottomSheet(context);

                      if (code == null) return;
                      ref
                          .read(authHomeStateNotifierProvider.notifier)
                          .countryCodeOnChanged(code, controller);
                    },
                    validation: (_) => ref
                        .read(authHomeStateNotifierProvider
                            .select((value) => value.phoneNumber))
                        .failureOrNever
                        .fold((left) => left.failureMessage, (_) => null),
                  ),
                  SizedBox(height: Constants.largeGridSpace.rh),
                  const DisclaimerText(),
                  const Spacer(),
                  TrybePrimaryButton(
                    key: AKey.getStartedContinueBtn,
                    onPressed: () => ref
                        .read(authHomeStateNotifierProvider.notifier)
                        .continueOnTap(context),
                    label: ButtonTitle.continueText,
                    isLoading: isLoading,
                  ),
                  SizedBox(height: Constants.largeGridSpace.rh),
                  Align(
                    child: RichText(
                      text: TextSpan(
                        text: 'Have an account? ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.primary,
                                  decorationThickness: 2,
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

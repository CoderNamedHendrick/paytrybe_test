import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/application/auth/create_account/create_account_notifier.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/shared/mixins/m_state.dart';
import 'package:paytrybe_test/shared/theme/app_texts.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/arrow_circle.dart';

import '../../../shared/constants.dart';
import '../widgets/auth_widgets.dart';

class CreateAccount extends ConsumerStatefulWidget {
  static const route = '/create-account';

  const CreateAccount({Key? key, required this.phone}) : super(key: key);
  final PhoneNumber phone;

  @override
  ConsumerState<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends ConsumerState<CreateAccount> with MState {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    postFrameCallback(() => ref
        .read(createAccountNotifierProvider.notifier)
        .initializePhone(widget.phone));
  }

  @override
  Widget build(BuildContext context) {
    postFrameCallback(() => controller.jumpToPage(ref
        .watch(createAccountNotifierProvider.select((value) => value.page))));
    return Scaffold(
      appBar: AppBar(
        leading: ArrowCircle(
          onTap: () => ref
              .read(createAccountNotifierProvider.notifier)
              .backOnTap(context),
        ),
        title: const Text(AppBarTitle.createAccount),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: Constants.horizontalPadding.rw,
            right: Constants.horizontalPadding.rw,
            top: Constants.largeGridSpace.rh,
            bottom: Constants.largeGridSpace.rh,
          ),
          child: PageView(
            controller: controller,
            children: const [VerifyPhoneNumberPage(), EmailAndPasswordPage()],
          ),
        ),
      ),
    );
  }
}

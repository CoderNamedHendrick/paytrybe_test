import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/buttons.dart';

import '../../../shared/constants.dart';

class ResendOTP extends StatefulWidget {
  const ResendOTP({
    Key? key,
    this.resendOTPOnTap,
  }) : super(key: key);
  final VoidCallback? resendOTPOnTap;

  @override
  State<ResendOTP> createState() => _ResendOTPState();
}

class _ResendOTPState extends State<ResendOTP>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  bool resendOtp = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => resendOtp = true);
        animationController.reset();
      }
    });

    if (mounted) {
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: Constants.mediumDurInMilli),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.decelerate,
      child: resendOtp
          ? SizedBox(
              height: 28.rh,
              child: TrybeOutlinedButton(
                label: 'Resend code',
                height: 28.rh,
                minWidth: 50,
                borderRadius: 14.rw,
                onTap: () async {
                  if (widget.resendOTPOnTap == null) return;

                  await Future.sync(() => widget.resendOTPOnTap!.call());
                  setState(() => resendOtp = false);
                  animationController.forward();
                },
                outlineColor: Theme.of(context).colorScheme.secondary,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          : AnimatedCountDown(listenable: animationController),
    );
  }
}

class AnimatedCountDown extends AnimatedWidget {
  const AnimatedCountDown({
    Key? key,
    required Animation<double> listenable,
  }) : super(key: key, listenable: listenable);

  Animation<int> get countDownAnimation {
    return IntTween(begin: 60, end: 0).animate(listenable as Animation<double>);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Expires in 00:${formatNumber(countDownAnimation.value)}',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  String formatNumber(int number) {
    if (number < 10) {
      return '0$number';
    }
    return number.toString();
  }
}

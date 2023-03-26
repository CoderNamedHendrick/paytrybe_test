import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

import '../../../../shared/constants.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
  });
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(Constants.xSmallGridSpace),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.smallRadius)),
      ),
      child: child,
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, this.padding});
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ??
          EdgeInsets.symmetric(vertical: Constants.sectionVerticalSpace.rh),
      height: 1,
      width: double.infinity,
      color: const Color(0xFFEFF3FB),
    );
  }
}

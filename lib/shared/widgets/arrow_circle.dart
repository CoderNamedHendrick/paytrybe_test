import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

class ArrowCircle extends StatelessWidget {
  const ArrowCircle({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () {},
      padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding.rw),
      icon: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: Constants.mediumIconSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

abstract class TypographyStyle {
  const TypographyStyle();

  static TextStyle xxLarge = xLarge.copyWith(
    fontSize: 26.rsp,
  );

  static TextStyle xLarge = TextStyle(
    fontSize: 24.rsp,
    fontWeight: FontWeight.w500,
    height: 1.195,
    leadingDistribution: TextLeadingDistribution.even,
    letterSpacing: 0.5,
  );

  static TextStyle large = xLarge.copyWith(
    fontSize: 20.rsp,
  );

  static TextStyle medium1 = xLarge.copyWith(
    fontSize: 16.rsp,
  );

  static TextStyle medium2 = xLarge.copyWith(
    fontSize: 14.rsp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium3 = xLarge.copyWith(
    fontSize: 13.rsp,
  );

  static TextStyle small1 = xLarge.copyWith(
    fontSize: 12.rsp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle small2 = xLarge.copyWith(
    fontSize: 11.rsp,
  );
}

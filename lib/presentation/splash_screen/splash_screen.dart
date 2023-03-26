import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/presentation/auth/pages/auth_home.dart';
import 'package:paytrybe_test/shared/mixins/m_state.dart';
import 'package:paytrybe_test/shared/theme/assets_extension.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with MState {
  @override
  void initState() {
    super.initState();

    postFrameCallback(
      () => Future.delayed(const Duration(milliseconds: 1200),
          () => Navigator.of(context).pushReplacementNamed(AuthHome.route)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'logo'.svg,
          key: AKey.splashScreenLogo,
          width: 135.rw,
          height: 20.rh,
        ),
      ),
    );
  }
}

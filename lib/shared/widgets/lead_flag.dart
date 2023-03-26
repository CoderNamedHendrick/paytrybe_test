import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

class LeadingFlag extends StatelessWidget {
  const LeadingFlag({
    super.key,
    required this.countryLogoPath,
    this.size = 16.0,
  });
  final String countryLogoPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: size.rw,
        width: size.rw,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: SvgPicture.asset(countryLogoPath, fit: BoxFit.cover),
      ),
    );
  }
}

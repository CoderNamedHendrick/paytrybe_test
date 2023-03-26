import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paytrybe_test/infrastructure/dtos/country_code.dart';
import 'package:paytrybe_test/shared/theme/assets_extension.dart';

class CountryCodesService {
  const CountryCodesService._();

  static const instance = CountryCodesService._();

  Future<List<CountryCode>> fetchCountryCodes() async {
    final jsonText = await rootBundle.loadString('country_codes'.json);

    final json = jsonDecode(jsonText) as List<dynamic>;

    return json
        .map((e) => CountryCode.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
  }
}

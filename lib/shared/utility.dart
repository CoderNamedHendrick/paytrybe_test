import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';

extension PhoneCodesX on String {
  String get internationalCode =>
      '+${PhoneCodes.getPhoneCountryDataByCountryCode(this)?.internalPhoneCode ?? 'N\\A'}';
}

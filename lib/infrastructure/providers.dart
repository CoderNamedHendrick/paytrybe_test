import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/infrastructure/services/country_codes_service.dart';

final countryCodesServiceProvider =
    Provider<CountryCodesService>((ref) => CountryCodesService.instance);

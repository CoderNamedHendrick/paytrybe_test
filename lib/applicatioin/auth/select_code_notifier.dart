// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paytrybe_test/applicatioin/core/trybe_view_model.dart';
import 'package:paytrybe_test/domain/core/exceptions.dart';
import 'package:paytrybe_test/infrastructure/providers.dart';

import '../../infrastructure/dtos/country_code.dart';
import '../../infrastructure/services/country_codes_service.dart';

final selectCountryNotifierProvider = StateNotifierProvider //
    .autoDispose<SelectCountryCodeNotifier, SelectCountryCodeViewModel>(
  (ref) => SelectCountryCodeNotifier(ref.read(countryCodesServiceProvider)),
);

class SelectCountryCodeNotifier
    extends StateNotifier<SelectCountryCodeViewModel> {
  final CountryCodesService _codesService;

  SelectCountryCodeNotifier(this._codesService)
      : super(SelectCountryCodeViewModel.initial()) {
    _initialiseCountryCodes();
  }

  void _initialiseCountryCodes() async {
    state = state.copyWith(viewState: ViewState.loading);
    final codes = await _codesService.fetchCountryCodes();

    state = state.copyWith(viewState: ViewState.success, countryCodes: codes);
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredCountryCodes: []);
      return;
    }

    state = state.copyWith(
      filteredCountryCodes: state.countryCodes
          .toSet()
          .where(
              (e) => e.countryName.toLowerCase().contains(query.toLowerCase()))
          .toList(growable: false),
    );
  }
}

class SelectCountryCodeViewModel extends TrybeViewModel {
  @override
  final ViewState viewState;
  @override
  final TrybeException error;
  final List<CountryCode> countryCodes;
  final List<CountryCode> filteredCountryCodes;

  const SelectCountryCodeViewModel({
    required this.viewState,
    required this.countryCodes,
    required this.filteredCountryCodes,
    required this.error,
  });

  factory SelectCountryCodeViewModel.initial() =>
      const SelectCountryCodeViewModel(
        viewState: ViewState.idle,
        countryCodes: [],
        filteredCountryCodes: [],
        error: MessageException(''),
      );

  SelectCountryCodeViewModel copyWith({
    ViewState? viewState,
    TrybeException? error,
    List<CountryCode>? countryCodes,
    List<CountryCode>? filteredCountryCodes,
  }) {
    return SelectCountryCodeViewModel(
      viewState: viewState ?? this.viewState,
      error: error ?? this.error,
      countryCodes: countryCodes ?? this.countryCodes,
      filteredCountryCodes: filteredCountryCodes ?? this.filteredCountryCodes,
    );
  }

  @override
  List<Object?> get props => [viewState, countryCodes, filteredCountryCodes];
}

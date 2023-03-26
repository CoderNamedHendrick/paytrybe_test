import 'package:paytrybe_test/shared/theme/assets_extension.dart';
import '../../../domain/auth/value_objects.dart';
import '../../../domain/core/exceptions.dart';
import '../../../infrastructure/dtos/country_code.dart';
import '../../core/trybe_view_model.dart';

class AuthHomeViewModel extends TrybeViewModel {
  final bool showFormErrors;
  final PhoneNumber phoneNumber;
  final CountryCode countryCode;
  @override
  final ViewState viewState;
  @override
  final TrybeException error;

  const AuthHomeViewModel({
    required this.phoneNumber,
    required this.countryCode,
    required this.viewState,
    required this.error,
    required this.showFormErrors,
  });

  factory AuthHomeViewModel.inital() => AuthHomeViewModel(
        phoneNumber: PhoneNumber(''),
        countryCode: CountryCode(
          countryName: 'Canada',
          countryCode: 'CA',
          countryLogo: 'canada'.svg,
        ),
        error: const MessageException(''),
        viewState: ViewState.idle,
        showFormErrors: false,
      );

  AuthHomeViewModel copyWith({
    bool? showFormErrors,
    PhoneNumber? phoneNumber,
    CountryCode? countryCode,
    ViewState? viewState,
    TrybeException? error,
  }) {
    return AuthHomeViewModel(
      showFormErrors: showFormErrors ?? this.showFormErrors,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      viewState: viewState ?? this.viewState,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'AuthHomeViewModel(phoneNumber: $phoneNumber, countryCode: $countryCode, viewState: $viewState, error: $error)';
  }

  @override
  List<Object?> get props => [viewState, countryCode, phoneNumber];
}

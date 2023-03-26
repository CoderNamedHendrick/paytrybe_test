import 'package:equatable/equatable.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/domain/core/value_failure.dart';

class CreateAccountEntity extends Equatable {
  final PhoneNumber phoneNumber;
  final OneTimePassword oneTimePassword;
  final FirstAndLastNames firstAndLastNames;
  final EmailAddress emailAddress;
  final Password password;

  const CreateAccountEntity({
    required this.phoneNumber,
    required this.oneTimePassword,
    required this.firstAndLastNames,
    required this.emailAddress,
    required this.password,
  });

  factory CreateAccountEntity.empty() => CreateAccountEntity(
        phoneNumber: PhoneNumber(''),
        oneTimePassword: OneTimePassword(''),
        firstAndLastNames: FirstAndLastNames(''),
        emailAddress: EmailAddress(''),
        password: Password(''),
      );

  CreateAccountEntity copyWith({
    PhoneNumber? phoneNumber,
    OneTimePassword? oneTimePassword,
    FirstAndLastNames? firstAndLastNames,
    EmailAddress? emailAddress,
    Password? password,
  }) {
    return CreateAccountEntity(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      oneTimePassword: oneTimePassword ?? this.oneTimePassword,
      firstAndLastNames: firstAndLastNames ?? this.firstAndLastNames,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
    );
  }

  ValueFailure<dynamic>? get failureOrNull {
    return phoneNumber.failureOrNever.fold(
      (left) => left,
      (_) => oneTimePassword.failureOrNever.fold(
        (left) => left,
        (_) => firstAndLastNames.failureOrNever.fold(
          (left) => left,
          (_) => emailAddress.failureOrNever.fold(
            (left) => left,
            (_) => password.failureOrNever.fold(
              (left) => left,
              (_) => null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  List<Object?> get props =>
      [oneTimePassword, firstAndLastNames, emailAddress, password];

  @override
  bool? get stringify => true;
}

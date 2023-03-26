import 'package:either_dart/either.dart';
import 'package:paytrybe_test/domain/auth/validators.dart';
import 'package:paytrybe_test/domain/core/value_failure.dart';
import 'package:paytrybe_test/domain/core/value_object.dart';
import 'package:paytrybe_test/shared/constants.dart';

class PhoneNumber extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static String countryCode = 'CA';

  factory PhoneNumber(String input) {
    return PhoneNumber._(phoneNumberValidator(input, countryCode));
  }

  const PhoneNumber._(this.value);
}

class OneTimePassword extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const otpLength = Constants.otpLength;

  factory OneTimePassword(String input) {
    return OneTimePassword._(otpValidator(input));
  }

  const OneTimePassword._(this.value);
}

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(emailValidator(input));
  }

  const EmailAddress._(this.value);
}

class FirstAndLastNames extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FirstAndLastNames(String input) {
    return FirstAndLastNames._(firstAndLastNameValidator(input));
  }

  const FirstAndLastNames._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;
  static const minimumLength = 8;

  factory Password(String input) {
    return Password._(passwordValidator(input));
  }

  const Password._(this.value);
}

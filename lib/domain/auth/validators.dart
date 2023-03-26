import 'package:either_dart/either.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/domain/core/value_failure.dart';

Either<ValueFailure<String>, String> phoneNumberValidator(String value,
    [String? countryCode]) {
  String failure = '';
  if (!isPhoneValid(value, defaultCountryCode: countryCode)) {
    failure = 'Please enter a valid phone number';
  }

  if (value.isEmpty) {
    failure = 'Phone Number cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

Either<ValueFailure<String>, String> otpValidator(String value) {
  String failure = '';

  if (value.length != OneTimePassword.otpLength) {
    failure = 'Please enter a valid otp';
  }

  if (value.isEmpty) {
    failure = 'OTP field cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

Either<ValueFailure<String>, String> emailValidator(String value) {
  const emailRegex = '[a-zA-Z0-9+._%-+]{1,256}'
      '\\@'
      '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}'
      '('
      '\\.'
      '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}'
      ')+';
  final regExp = RegExp(emailRegex);
  String failure = '';

  if (!regExp.hasMatch(value)) {
    failure = 'Please enter a valid email';
  }
  if (value.isEmpty) {
    failure = 'Email cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

Either<ValueFailure<String>, String> passwordValidator(String value) {
  String failure = '';

  if (value.length < Password.minimumLength) {
    failure = 'Please enter ${Password.minimumLength} or more characters';
  }
  if (value.isEmpty) {
    failure = 'Password cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

Either<ValueFailure<String>, String> firstAndLastNameValidator(String value) {
  String failure = '';

  if (value.isNotEmpty) {
    final names = value.split(' ');
    failure = _namesValidation(names);
  }
  if (value.isEmpty) {
    failure = 'First Name and Last Name cannot be empty';
  }

  if (failure.isNotEmpty) return Left(ValueFailure(value, failure));

  return Right(value);
}

String _namesValidation(List<String> names) {
  if (names.length == 1) {
    return 'Please enter your Last Name';
  }

  if (names.length >= 3) {
    return 'Please enter names in First-Name Last-Name format';
  }

  if (names[0].length < 3) {
    return 'Please ensure first name is 3 or more characters';
  }

  if (names[1].length < 3) {
    return 'Please ensure last name is 3 or more characters';
  }

  return '';
}

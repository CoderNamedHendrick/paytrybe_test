import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paytrybe_test/domain/auth/value_objects.dart';
import 'package:paytrybe_test/shared/utility.dart';

void main() {
  const phone = '905 615 3649';
  group('Test the validity of domain validators', () {
    test('Phone Number Type', () async {
      PhoneNumber phoneNumber = PhoneNumber('');
      expect(
          phoneNumber.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Phone Number cannot be empty');

      PhoneNumber.countryCode = 'CA';
      phoneNumber = PhoneNumber('453 532 889');

      // invalid phone number
      expect(
          phoneNumber.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter a valid phone number');

      PhoneNumber.countryCode = 'NG';
      phoneNumber = PhoneNumber(phone);

      // ensure the correct country code is returned.
      expect(PhoneNumber.countryCode.internationalCode, '+234');
      expect(phoneNumber.value, const Right(phone));
    });

    test('One Time Password Type', () {
      OneTimePassword oneTimePassword = OneTimePassword('');
      expect(
          oneTimePassword.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'OTP field cannot be empty');

      oneTimePassword = OneTimePassword('1243');
      expect(
          oneTimePassword.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter a valid otp');

      oneTimePassword = OneTimePassword('123456');
      expect(oneTimePassword.value, const Right('123456'));
    });

    test('Email Address Type', () {
      EmailAddress emailAddress = EmailAddress('');
      expect(
          emailAddress.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Email cannot be empty');

      emailAddress = EmailAddress('sebastinesoacatp');
      expect(
          emailAddress.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter a valid email');

      emailAddress = EmailAddress('sebastinesoacatp@gmail.com');
      expect(emailAddress.value, const Right('sebastinesoacatp@gmail.com'));
    });

    test('First Name and Last Name Type', () {
      FirstAndLastNames firstAndLastNames = FirstAndLastNames('');
      expect(
          firstAndLastNames.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'First Name and Last Name cannot be empty');

      firstAndLastNames = FirstAndLastNames('Sebastine');
      expect(
          firstAndLastNames.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter your Last Name');

      firstAndLastNames = FirstAndLastNames('Seb Odeh Doe');
      expect(
          firstAndLastNames.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter names in First-Name Last-Name format');

      firstAndLastNames = FirstAndLastNames('Se Su');
      expect(
          firstAndLastNames.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please ensure first name is 3 or more characters');

      firstAndLastNames = FirstAndLastNames('Seb Su');
      expect(
          firstAndLastNames.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please ensure last name is 3 or more characters');

      firstAndLastNames = FirstAndLastNames('John Doe');
      expect(firstAndLastNames.value, const Right('John Doe'));
    });

    test('Password Type', () {
      Password password = Password('');
      expect(
          password.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Password cannot be empty');

      password = Password('John');
      expect(
          password.failureOrNever
              .fold((left) => left.failureMessage, (_) => null),
          'Please enter ${Password.minimumLength} or more characters');

      password = Password('Barbecue');
      expect(password.value, const Right('Barbecue'));
    });
  });
}

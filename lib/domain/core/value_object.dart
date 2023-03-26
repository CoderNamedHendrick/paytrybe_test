import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import 'value_failure.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((left) => throw Error(), (right) => right);
  }

  T? getOr() {
    return value.fold((left) => null, (right) => right);
  }

  bool get isValid => value.isRight;

  Either<ValueFailure<dynamic>, Object> get failureOrNever {
    return value.fold(
      (left) => Left(left),
      (right) => const Right(Never),
    );
  }

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}

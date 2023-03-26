class ValueFailure<T> {
  const ValueFailure(
    T failedValue,
    String message,
  )   : _failedValue = failedValue,
        _message = message;

  final T _failedValue;
  final String _message;

  String get failureMessage => _message;

  T get value => _failedValue;
}

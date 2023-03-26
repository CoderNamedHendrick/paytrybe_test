abstract class TrybeException implements Exception {
  const TrybeException();
}

class MessageException extends TrybeException {
  final String message;

  const MessageException(this.message);

  @override
  String toString() => message;
}

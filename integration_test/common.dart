// serves as a buffer/manual pause after performing actions
import 'package:flutter_test/flutter_test.dart';

const waitDuration = Duration(milliseconds: 800);

void trybeTester(
  String description,
  Future<void> Function(WidgetTester) callback, {
  bool skip = false,
}) =>
    testWidgets(
      description,
      callback,
      skip: skip,
      timeout: const Timeout(Duration(seconds: 60)),
    );

extension WidgetTesterX on WidgetTester {
  /// run the loading animation while counteracting the countdown animation
  /// pumpAndSettle timeout issue
  Future<void> progressAnimationSafely() async {
    for (int i = 0; i < 5; i++) {
      await pump(waitDuration);
    }
  }
}

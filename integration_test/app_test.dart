import 'package:flutter_test/flutter_test.dart';
import 'scenarios/home_test.dart' as home_test;
import 'scenarios/sign_up_test.dart' as sign_up;

void main() {
  group('E2E testing suite', () {
    sign_up.main();
    home_test.main();
  });
}

import 'package:flutter/cupertino.dart';

mixin MState<T extends StatefulWidget> on State<T> {
  void postFrameCallback(Function() function) {
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((_) => function());
  }
}

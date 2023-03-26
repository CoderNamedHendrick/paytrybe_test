import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/constants.dart';

class AnimatedIndexedStack extends StatelessWidget {
  const AnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: Constants.shortDurInMilli),
  }) : super(key: key);
  final int index;
  final List<Widget> children;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        for (var i = 0; i < children.length; i++)
          AnimatedScale(
            scale: index == i ? 1.0 : 0.95,
            curve: Curves.fastOutSlowIn,
            duration: duration,
            child: AnimatedOpacity(
              opacity: index == i ? 1.0 : 0.0,
              duration: duration,
              child: children[i],
            ),
          ),
      ],
    );
  }
}

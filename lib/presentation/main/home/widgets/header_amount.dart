import 'package:flutter/material.dart';

class HeaderAmount extends StatelessWidget {
  const HeaderAmount({
    super.key,
    this.amount = 0,
  });
  final int amount;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '\$',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.66),
              fontWeight: FontWeight.w600,
            ),
        children: [
          TextSpan(
            text: amount.toString(),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const TextSpan(text: '.00'),
        ],
      ),
    );
  }
}

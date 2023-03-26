import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/widgets/trybe_webview.dart';

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'By continuing you agree to the Paytrybe ',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
        children: [
          TextSpan(
            text: 'Platform Terms & Conditions,',
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TrybeWebview(
                        url:
                            'https://www.neofinancial.com/legal/platform-policy',
                        title: 'Terms & Conditions',
                      ),
                    ),
                  ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const TextSpan(text: ' '),
          TextSpan(
            text: 'Rewards Policy',
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TrybeWebview(
                        url:
                            'https://www.neofinancial.com/legal/rewards-policy',
                        title: 'Rewards Policy',
                      ),
                    ),
                  ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy.',
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TrybeWebview(
                        url:
                            'https://www.neofinancial.com/legal/privacy-policy',
                        title: 'Privacy Policy',
                      ),
                    ),
                  ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}

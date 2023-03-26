import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

class TransactionActionTile extends StatelessWidget {
  const TransactionActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final Widget icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: SizedBox(
        height: 70.rh,
        width: 80.rw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

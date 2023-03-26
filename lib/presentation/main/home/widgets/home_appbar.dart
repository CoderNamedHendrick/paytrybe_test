import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

import '../../../../shared/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.bottomLeft,
            child: HomeAppBarLeading(),
          ),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.only(
                left: Constants.horizontalPadding.rw),
            icon: CircleAvatar(
              minRadius: 13.5.rw,
              maxRadius: 13.5.rw,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(
                Icons.notifications_outlined,
                size: 16.rw,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBarLeading extends StatelessWidget {
  const HomeAppBarLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 7.rh),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: const BorderRadius.all(
              Radius.circular(Constants.smallRadius + 12))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            minRadius: 7.39.rw,
            maxRadius: 7.39.rw,
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            child: Text(
              'P',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10.5.rsp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(width: 8.rw),
          Text(
            '\$Paytrybe',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 10.5.rsp,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}

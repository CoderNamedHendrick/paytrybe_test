import 'package:flutter/material.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';

import '../../../../shared/constants.dart';

class GetStartedActionsTile extends StatelessWidget {
  const GetStartedActionsTile({
    super.key,
    required this.leading,
    required this.titleText,
    required this.subtitleText,
    this.isCompleted = false,
  });
  final Widget leading;
  final String titleText;
  final String subtitleText;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leading,
                  SizedBox(width: Constants.sectionHorizontalSpace.rw),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 5.rh),
                        Text(
                          subtitleText,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: const Color(0xFF023564).withOpacity(0.7),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: Constants.sectionHorizontalSpace.rw),
          SizedBox(
            height: 34.rw,
            width: 34.rw,
            child: Icon(
              Icons.check_circle,
              color: isCompleted
                  ? const Color(0xFF27AE60)
                  : const Color(0xFFD9D9D9),
              size: Constants.mediumIconSize.rw,
            ),
          )
        ],
      ),
    );
  }
}

class LeadingWithIcon extends StatelessWidget {
  const LeadingWithIcon({
    super.key,
    required this.icon,
    required this.backgroundColor,
  });
  final Widget icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      minRadius: 16.rw,
      maxRadius: 16.rw,
      child: icon,
    );
  }
}

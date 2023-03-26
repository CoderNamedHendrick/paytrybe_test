import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TrybePrimaryButton extends StatelessWidget {
  const TrybePrimaryButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.largeRadius)),
          child: MaterialButton(
            onPressed: onPressed,
            height: 51,
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onSurface,
            elevation: 0.2,
            child: isLoading
                ? CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.background,
                    radius: 12,
                  )
                : Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
        ),
      ),
    );
  }
}

class TrybeFilledButton extends StatelessWidget {
  const TrybeFilledButton({
    super.key,
    required this.label,
    this.onTap,
    this.height,
    this.labelStyle,
    this.padding,
    this.borderRadius,
    this.minWidth,
    this.textColor,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;

  // configuration parameters
  final double? height;
  final double? borderRadius;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final double? minWidth;
  final bool isLoading;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Semantics(
        label: '$label Text Button',
        child: MaterialButton(
          onPressed: onTap,
          color: Theme.of(context).colorScheme.onSurface,
          focusColor: Colors.transparent,
          disabledColor: const Color(0xff7a7878),
          textColor: Theme.of(context).colorScheme.onSurface,
          hoverColor: Theme.of(context).buttonTheme.colorScheme?.primary,
          elevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          shape: borderRadius == null
              ? null
              : RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius!))),
          height: height ?? 55,
          padding: padding,
          minWidth: minWidth,
          child: isLoading
              ? CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.background,
                  radius: 12,
                )
              : Text(
                  label,
                  style: (labelStyle ?? Theme.of(context).textTheme.bodyMedium)
                      ?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

class TrybeOutlinedButton extends StatelessWidget {
  const TrybeOutlinedButton({
    super.key,
    this.outlineColor,
    required this.label,
    this.onTap,
    this.height,
    this.borderRadius,
    this.labelStyle,
    this.padding,
    this.minWidth,
    this.borderWidth,
    this.isLoading = false,
  });

  final Color? outlineColor;
  final String label;
  final VoidCallback? onTap;

  // configuration parameters
  final double? height;
  final double? borderRadius;
  final TextStyle? labelStyle;
  final EdgeInsets? padding;
  final double? minWidth;
  final double? borderWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Semantics(
        label: '$label Outlined Button',
        child: OutlinedButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            minimumSize: MaterialStateProperty.all(
                Size(minWidth ?? double.infinity, height ?? 55)),
            side: MaterialStateProperty.all(
              BorderSide(
                width: borderWidth ?? 1,
                color: outlineColor ?? Theme.of(context).colorScheme.onSurface,
              ),
            ),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(padding),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius ?? Constants.smallRadius)))),
          ),
          child: isLoading
              ? CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.background,
                  radius: 12,
                )
              : Text(
                  label,
                  style: labelStyle ??
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                ),
        ),
      ),
    );
  }
}

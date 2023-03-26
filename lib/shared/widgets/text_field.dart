import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytrybe_test/shared/theme/colors.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:pinput/pinput.dart';

import '../constants.dart';

class TrybeTextField extends StatefulWidget {
  const TrybeTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.label,
    this.validation,
    this.onChanged,
    this.readOnly = false,
    this.obscureText = false,
    this.enabled = true,
    this.inputFormatters,
    this.onEditingComplete,
    this.onTap,
    this.prefix,
    this.suffix,
    this.semanticsLabel,
    this.downArrowAction,
    this.upArrowAction,
    this.onDonePress,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    EdgeInsets? contentPadding,
    this.isLabelInTextField = false,
    this.border,
    this.backgroundColor,
    this.prefixText,
  })  : _contentPadding = contentPadding,
        super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool obscureText;
  final bool enabled;

  final String? label;
  final String? Function(String?)? validation;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;

  final Widget? prefix;
  final Widget? suffix;
  final String? prefixText;

  final String? semanticsLabel;

  final VoidCallback? upArrowAction;
  final VoidCallback? downArrowAction;
  final VoidCallback? onDonePress;
  final int? maxLines;
  final int? maxLength;

  final EdgeInsets? _contentPadding;
  final String? hintText;

  final bool isLabelInTextField;
  final InputBorder? border;
  final Color? backgroundColor;

  @override
  State<TrybeTextField> createState() => _TrybeTextFieldState();
}

class _TrybeTextFieldState extends State<TrybeTextField> {
  final ValueNotifier<String?> error = ValueNotifier(null);
  final ValueNotifier<Border> labelInTextFieldBorder = ValueNotifier(Border.all(
    color: AColor.secondary,
    width: 0.8,
  ));
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        labelInTextFieldBorder.value = Border.all(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          width: 0.8,
        );
        if (Platform.isIOS && !widget.readOnly) {
          _KeyboardOverlay.showOverlay(context,
              upButtonPressed: widget.upArrowAction,
              downButtonPressed: widget.downArrowAction,
              onDonePress:
                  widget.onDonePress ?? FocusScope.of(context).unfocus);
        }
      } else {
        labelInTextFieldBorder.value = Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 0.8,
        );
        if (Platform.isIOS && !widget.readOnly) {
          _KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: error,
      builder: (context, errorValue, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.label != null && !widget.isLabelInTextField) ...[
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              SizedBox(height: 5.rh),
            ],
            if (widget.isLabelInTextField)
              ValueListenableBuilder<Border>(
                valueListenable: labelInTextFieldBorder,
                builder: (_, borderValue, child) => AnimatedContainer(
                  duration:
                      const Duration(milliseconds: Constants.shortDurInMilli),
                  height: 66.rh,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.smallRadius)),
                    border: errorValue != null && errorValue.isNotEmpty
                        ? Border.all(
                            color: Theme.of(context).colorScheme.error,
                            width: 0.8,
                          )
                        : borderValue,
                  ),
                  child: child,
                ),
                child: SizedBox(
                  height: 36.rh,
                  child: textfield,
                ),
              )
            else
              textfield,
            if (errorValue != null && errorValue.isNotEmpty) ...[
              SizedBox(height: 5.rh),
              Text(
                errorValue,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                textAlign: TextAlign.end,
              ),
            ]
          ],
        );
      },
    );
  }

  Widget get textfield => Semantics(
        label: widget.semanticsLabel,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(Constants.smallRadius)),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: focusNode,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            textInputAction: widget.textInputAction,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            validator: (v) {
              error.value = widget.validation?.call(v);
              return error.value;
            },
            onTap: widget.onTap,
            onEditingComplete: widget.onEditingComplete,
            inputFormatters: widget.inputFormatters,
            cursorColor: Theme.of(context).colorScheme.onBackground,
            decoration: InputDecoration(
              border:
                  widget.isLabelInTextField ? InputBorder.none : widget.border,
              enabledBorder:
                  widget.isLabelInTextField ? InputBorder.none : widget.border,
              focusedBorder:
                  widget.isLabelInTextField ? InputBorder.none : widget.border,
              errorBorder:
                  widget.isLabelInTextField ? InputBorder.none : widget.border,
              fillColor: widget.backgroundColor,
              filled: widget.backgroundColor != null,
              focusColor: widget.backgroundColor,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: widget.isLabelInTextField ? widget.label : null,
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.68),
                  ),
              floatingLabelStyle:
                  Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.68),
                        fontWeight: FontWeight.w500,
                      ),
              prefixIcon: widget.prefix,
              prefixText: widget.prefixText,
              prefixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              prefixIconConstraints: const BoxConstraints(maxWidth: 100),
              suffixIcon: widget.suffix,
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              contentPadding: widget._contentPadding ??
                  EdgeInsets.symmetric(horizontal: 14.rw, vertical: 14.rh),
              errorStyle:
                  const TextStyle(color: Colors.transparent, height: 0.001),
              counterText: widget.maxLength?.toString(),
              counterStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                  ),
            ),
          ),
        ),
      );
}

class OTPTextField extends StatefulWidget {
  const OTPTextField({
    super.key,
    this.onChanged,
    this.validation,
    this.controller,
    this.upArrowAction,
    this.downArrowAction,
    this.onDonePress,
  });
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validation;
  final TextEditingController? controller;
  final VoidCallback? upArrowAction;
  final VoidCallback? downArrowAction;
  final VoidCallback? onDonePress;

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (Platform.isIOS) {
          _KeyboardOverlay.showOverlay(context,
              upButtonPressed: widget.upArrowAction,
              downButtonPressed: widget.downArrowAction,
              onDonePress:
                  widget.onDonePress ?? FocusScope.of(context).unfocus);
        }
      } else {
        if (Platform.isIOS) {
          _KeyboardOverlay.removeOverlay();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      focusNode: focusNode,
      length: Constants.otpLength,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validation,
      defaultPinTheme: PinTheme(
        width: Constants.otpSize,
        height: Constants.otpSize,
        margin: EdgeInsets.only(right: 9.rw),
        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.otpRadius)),
        ),
      ),
      disabledPinTheme: PinTheme(
        width: Constants.otpSize,
        height: Constants.otpSize,
        margin: EdgeInsets.only(right: 9.rw),
        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.otpRadius)),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: Constants.otpSize,
        height: Constants.otpSize,
        margin: EdgeInsets.only(right: 9.rw),
        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).colorScheme.secondary,
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.otpRadius)),
        ),
      ),
      errorPinTheme: PinTheme(
        width: Constants.otpSize,
        height: Constants.otpSize,
        margin: EdgeInsets.only(right: 9.rw),
        textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius:
              const BorderRadius.all(Radius.circular(Constants.otpRadius)),
        ),
      ),
    );
  }
}

/// Wrapper for done keyboard overlay, used especially on ios to close
/// the keyboard
class _KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(BuildContext context,
      {VoidCallback? upButtonPressed,
      VoidCallback? downButtonPressed,
      VoidCallback? onDonePress}) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: _InputDoneView(
            upButtonPressed: upButtonPressed,
            downButtonPressed: downButtonPressed,
            onDonePress: onDonePress,
          ),
        );
      },
    );

    overlayState.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class _InputDoneView extends StatelessWidget {
  const _InputDoneView(
      {Key? key,
      this.downButtonPressed,
      this.upButtonPressed,
      this.onDonePress})
      : super(key: key);
  final VoidCallback? downButtonPressed;
  final VoidCallback? upButtonPressed;
  final VoidCallback? onDonePress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CupertinoColors.extraLightBackgroundGray,
      height: 45,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Theme(
                data: ThemeData(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoButton(
                      onPressed: upButtonPressed,
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: downButtonPressed,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding:
                    const EdgeInsets.only(right: 24.0, top: 10.0, bottom: 10.0),
                onPressed: () {
                  if (onDonePress != null) {
                    onDonePress?.call();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                  Scrollable.ensureVisible(context,
                      alignment: 0, duration: const Duration(seconds: 1));
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

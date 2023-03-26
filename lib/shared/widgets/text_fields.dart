import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytrybe_test/keys.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/text_field.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.hintText = 'Search country',
    this.onChanged,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TrybeTextField(
      border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.smallRadius)),
          borderSide: BorderSide(color: Colors.transparent, width: 0.8)),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      prefix: const SizedBox(
        width: 54,
        child: Align(
          child: Icon(
            Icons.search,
            color: Color(0xFF808080),
          ),
        ),
      ),
      hintText: hintText,
      onChanged: onChanged,
    );
  }
}

class CountryCodeTextField extends StatelessWidget {
  const CountryCodeTextField({
    super.key,
    required this.countryLogoPath,
    this.changeCountryOnTap,
    this.onChanged,
    this.labelText,
    required this.phoneFormatter,
    this.validation,
    this.onEditingComplete,
    required this.countryCode,
    this.controller,
  });

  final ValueChanged<String>? onChanged;
  final String countryLogoPath;
  final VoidCallback? changeCountryOnTap;
  final VoidCallback? onEditingComplete;
  final String? labelText;
  final TextInputFormatter phoneFormatter;
  final String? Function(String?)? validation;
  final String countryCode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TrybeTextField(
      controller: controller,
      label: labelText,
      isLabelInTextField: false,
      validation: validation,
      onEditingComplete: onEditingComplete,
      onDonePress: onEditingComplete,
      onChanged: onChanged,
      prefixText: countryCode,
      prefix: _CountryCodeDropdown(
        key: AKey.dropdownBtn,
        countryLogoPath: countryLogoPath,
        onTap: changeCountryOnTap,
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [phoneFormatter],
    );
  }
}

class _CountryCodeDropdown extends StatelessWidget {
  const _CountryCodeDropdown({
    super.key,
    required this.countryLogoPath,
    this.onTap,
  });

  final String countryLogoPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 14.rh),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(Constants.smallerRadius)),
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.secondary),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 8.rh),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 13.5.rh,
                width: 18.rw,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
                child: SvgPicture.asset(
                  countryLogoPath,
                  fit: BoxFit.cover,
                  placeholderBuilder: (_) => const Icon(Icons.flag),
                ),
              ),
              SizedBox(width: Constants.smallHorizontalGrid.rw),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: Constants.mediumIconSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

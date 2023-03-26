import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paytrybe_test/applicatioin/auth/select_code_notifier.dart';
import 'package:paytrybe_test/applicatioin/core/trybe_view_model.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/widgets.dart';

import '../../../infrastructure/dtos/country_code.dart';

Future<CountryCode?> showSelectCountryBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Constants.mediumRadius),
      ),
    ),
    builder: (context) => const _SelectCountryCodeWidget(),
  );
}

class _SelectCountryCodeWidget extends ConsumerWidget {
  const _SelectCountryCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Constants.mediumGridSpace.rw,
          vertical: Constants.smallGridSpace.rh,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: Constants.mediumDurInMilli),
          curve: Curves.easeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select your country',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              SizedBox(height: Constants.smallGridSpace.rh - 2),
              SearchTextField(
                onChanged: ref
                    .read(selectCountryNotifierProvider.notifier)
                    .filterCountries,
              ),
              SizedBox(height: Constants.mediumGridSpace.rh),
              ref.watch(selectCountryNotifierProvider
                          .select((value) => value.viewState)) ==
                      ViewState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : const _CountriesList(),
              SizedBox(height: Constants.mediumGridSpace.rh),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountriesList extends ConsumerWidget {
  const _CountriesList();

  @override
  Widget build(BuildContext context, ref) {
    final countries = ref
            .watch(selectCountryNotifierProvider
                .select((value) => value.filteredCountryCodes))
            .isEmpty
        ? ref.watch(
            selectCountryNotifierProvider.select((value) => value.countryCodes))
        : ref.watch(selectCountryNotifierProvider
            .select((value) => value.filteredCountryCodes));
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => CountryTile(
        onTap: () => Navigator.of(context).pop(countries[index]),
        logoUrl: countries[index].countryLogo,
        titleText: countries[index].countryName,
        countryCode: countries[index].countryCode,
      ),
      separatorBuilder: (context, index) =>
          SizedBox(height: Constants.smallHorizontalGrid.rh),
      itemCount: countries.length,
    );
  }
}

class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.titleText,
    required this.logoUrl,
    required this.countryCode,
    this.onTap,
  });
  final String titleText;
  final String logoUrl;
  final String countryCode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Constants.xSmallGridSpace,
            horizontal: Constants.smallHorizontalGrid),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LeadingFlag(countryLogoPath: logoUrl),
                const SizedBox(width: Constants.xSmallGridSpace),
                Text(
                  titleText,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
            Text(
              '+${PhoneCodes.getPhoneCountryDataByCountryCode(countryCode)?.internalPhoneCode ?? 'N\\A'}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytrybe_test/shared/constants.dart';
import 'package:paytrybe_test/shared/theme/assets_extension.dart';
import 'package:paytrybe_test/shared/theme/sizing_extension.dart';
import 'package:paytrybe_test/shared/widgets/widgets.dart';

import '../widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.horizontalPadding,
            ),
            child: Column(
              children: [
                const HomeAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Constants.mediumGridSpace.rh),
                        const HeaderAmount(amount: 100),
                        SizedBox(height: Constants.smallGridSpace.rh),
                        const CurrencySwitch(),
                        SizedBox(height: Constants.mediumGridSpace.rh),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 41.rh,
                                child: TrybeOutlinedButton(
                                  label: 'Add Money',
                                  height: 41.rh,
                                  onTap: () {},
                                ),
                              ),
                            ),
                            SizedBox(width: Constants.sectionHorizontalSpace.rw),
                            Expanded(
                              child: SizedBox(
                                height: 41.rh,
                                child: TrybeFilledButton(
                                  label: 'Send Money',
                                  borderRadius: 6,
                                  height: 41.rh,
                                  onTap: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Constants.smallGridSpace.rh),
                        const TransactionSection(),
                        SizedBox(height: Constants.largeGridSpace.rh),
                        const Center(child: GetStartedSection()),
                        SizedBox(height: Constants.largeGridSpace.rh),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencySwitch extends StatelessWidget {
  const CurrencySwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.rw,
        vertical: 5.rw,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFEBF0FF),
          width: 1.0,
        ),
        borderRadius:
            const BorderRadius.all(Radius.circular(Constants.largeRadius)),
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LeadingFlag(
            countryLogoPath: 'canada'.svg,
            size: 20,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Constants.xSmallGridSpace.rw),
            child: Text(
              'CAD Dollar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          CircleAvatar(
            minRadius: 7,
            maxRadius: 7,
            backgroundColor: const Color(0xFFEBF0FF),
            child: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.primary,
              size: 14,
            ),
          )
        ],
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  const TransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(vertical: 24.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TransactionActionTile(
            icon: Icon(
              Icons.add_circle,
              size: 28.rw,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: 'Request Money',
            onTap: () {},
          ),
          TransactionActionTile(
            icon: SvgPicture.asset(
              'exchange_currency'.svg,
              height: 28.rw,
              width: 28.rw,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: 'Exchange Currency',
            onTap: () {},
          ),
          TransactionActionTile(
            icon: SvgPicture.asset(
              'phone'.svg,
              height: 28.rw,
              width: 28.rw,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: 'Buy Airtime',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class GetStartedSection extends StatelessWidget {
  const GetStartedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Getting started',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.68),
                ),
          ),
          SizedBox(height: Constants.sectionVerticalSpace.rh),
          GetStartedActionsTile(
            titleText: 'Verify Email',
            subtitleText:
                'To protect your account we need to verify your e-mail address',
            isCompleted: true,
            leading: LeadingWithIcon(
              icon: SvgPicture.asset(
                'mail'.svg,
                height: 20.rw,
                width: 20.rw,
              ),
              backgroundColor: const Color(0xFFEFF3FB),
            ),
          ),
          const SectionDivider(),
          GetStartedActionsTile(
            titleText: 'Verify Identity',
            subtitleText:
                'To protect your account we need to verify your e-mail address',
            isCompleted: true,
            leading: LeadingWithIcon(
              icon: SvgPicture.asset(
                'shield'.svg,
                height: 20.rw,
                width: 20.rw,
              ),
              backgroundColor: const Color(0xFFEFFBF4),
            ),
          ),
          const SectionDivider(),
          GetStartedActionsTile(
            titleText: 'Fund Account',
            subtitleText:
                'To protect your account we need to verify your e-mail address',
            leading: LeadingWithIcon(
              icon: SvgPicture.asset(
                'piggy_bank'.svg,
                height: 20.rw,
                width: 20.rw,
              ),
              backgroundColor: const Color(0xFFF3EBFF),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/configs/router/app_routes.dart';

class CampaignRequestJoin extends StatelessWidget {
  const CampaignRequestJoin({
    super.key,
    required this.campaign,
  });
  final CampaignModel campaign;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppRoundedButton(
            width: double.infinity,
            isDisable: campaign.registerLink == null,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.campaignRegister,
                arguments: campaign,
              );
            },
            content: LocaleKeys.button_join.tr(),
          ),
        ),
        const VerticalDivider(
          width: 10,
          color: Colors.transparent,
        ),
        Expanded(
          child: AppRoundedButton(
            isDisable: campaign.donationRequirement == null,
            width: double.infinity,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.donate,
                arguments: campaign.id,
              );
            },
            content: LocaleKeys.button_donate.tr(),
          ),
        ),
      ],
    );
  }
}

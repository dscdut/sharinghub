import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_read_more_text.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/icon_title.widget.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/info_card.widget.dart';

class CampaignDetailInfo extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignDetailInfo({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTitle(
            icon: Icons.fmd_good_outlined,
            title: campaign.address.fullAddress,
          ),
          const SizedBox(
            height: 5,
          ),
          IconTitle(
            icon: Icons.event_outlined,
            title: campaign.fullDate,
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.campaign_artifact_type.tr()}: ',
                  style: TextStyles.s14BoldText.copyWith(color: Colors.green),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                TextSpan(
                  text: campaign.artifactRequirement,
                  style: TextStyles.s14RegularText,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (!campaign.isOngoing)
            AppReadMoreText(
              content:
                  '${LocaleKeys.campaign_obtained_results.tr()}: Xây được 100 căn',
              style: TextStyles.s14BoldText.copyWith(color: Colors.green),
            )
        ],
      ),
    );
  }
}

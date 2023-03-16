import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_read_more_text.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/icon_title.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

class CampaignDetailInfo extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignDetailInfo({
    super.key,
    required this.campaign,
  });

  final Widget _verticalSpacing = const SizedBox(
    height: 8,
  );

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTitle(
            icon: Icons.fmd_good_outlined,
            title: campaign.address,
          ),
          _verticalSpacing,
          Row(
            children: [
              const Icon(
                Icons.event_outlined,
                color: ColorStyles.zodiacBlue,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: campaign.fullDate,
                        style: TextStyles.s14RegularText,
                      ),
                      TextSpan(
                        text:
                            ' (${campaign.isOngoing ? LocaleKeys.campaign_ongoing.tr() : LocaleKeys.campaign_ended.tr()})',
                        style: TextStyles.s14BoldText
                            .copyWith(color: Colors.green),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          _verticalSpacing,
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
                  text: campaign.donationRequirement,
                  style: TextStyles.s14RegularText,
                ),
              ],
            ),
          ),
          _verticalSpacing,
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

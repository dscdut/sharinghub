import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
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

  String _getCampaignStatusDisplay(CampaignModel campaign) {
    return ' ${campaign.startDate.toDisplay} - ${campaign.endDate.toDisplay}';
  }

  TextStyle _getCampaignStatusTextStyle(CampaignModel campaign) {
    final color = _getColorForCampaignStatus(campaign);
    return TextStyles.s14BoldText.copyWith(color: color);
  }

  Color _getColorForCampaignStatus(CampaignModel campaign) {
    if (campaign.isUpcoming) {
      return Colors.orange;
    } else if (campaign.isOngoing) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

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
                        text: campaign.statusContent,
                        style: _getCampaignStatusTextStyle(campaign),
                      ),
                      TextSpan(
                        text: _getCampaignStatusDisplay(campaign),
                        style: TextStyles.s14RegularText,
                      ),
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
                  text: (campaign.donationRequirement == '' ||
                          campaign.donationRequirement == null)
                      ? LocaleKeys.campaign_artifact_empty.tr()
                      : campaign.donationRequirement,
                  style: TextStyles.s14RegularText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/dynamic.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/show_multiple_image.widget.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_feedback_field.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

class CampaignOrgFeedback extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignOrgFeedback({super.key, required this.campaign});

  final verticalSpacing = const SizedBox(
    height: 12,
  );

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.campaign_location_review.tr(),
            style: TextStyles.boldBody16,
          ),
          verticalSpacing,
          StarRating(
            rating: campaign.feedback?.locationRate ?? 0,
            color: ColorStyles.zodiacBlue,
            size: 35,
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_traffic.tr(),
            content: campaign.feedback?.traffic ?? '',
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_weather.tr(),
            content: campaign.feedback?.weather ?? '',
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_santization.tr(),
            content: campaign.feedback?.sanitization ?? '',
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_residence.tr(),
            content: campaign.feedback?.residence ?? '',
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_authority_cooperation.tr(),
            content: campaign.feedback?.authorityCooperation ?? '',
          ),
          verticalSpacing,
          CampaignFeedbackField(
            title: LocaleKeys.feedback_others.tr(),
            content: campaign.feedback?.others ?? '',
          ),
          verticalSpacing,
          Text(
            LocaleKeys.campaign_images.tr(),
            style: TextStyles.boldBody16,
          ),
          verticalSpacing,
          if (campaign.feedback?.images.isNotNullOrEmpty == true)
            ShowMultipleImage(images: campaign.feedback!.images!)
        ],
      ),
    );
  }
}

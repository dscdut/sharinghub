import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class CampaignEndedInfo extends StatelessWidget {
  const CampaignEndedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline_rounded,
          color: ColorStyles.red400,
          size: 30,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '${LocaleKeys.campaign_has_ended.tr()}!',
          style: TextStyles.s17MediumText.copyWith(color: ColorStyles.red500),
        ),
      ],
    );
  }
}

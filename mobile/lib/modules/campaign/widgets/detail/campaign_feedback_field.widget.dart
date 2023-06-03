import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class CampaignFeedbackField extends StatelessWidget {
  final String title;
  final String content;
  const CampaignFeedbackField({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorStyles.disableColor.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$title: $content',
        style: TextStyles.regularBody14,
      ),
    );
  }
}

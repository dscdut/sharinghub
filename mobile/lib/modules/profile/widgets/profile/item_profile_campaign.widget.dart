import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';

class ItemProfileCampaignWidget extends StatelessWidget {
  const ItemProfileCampaignWidget({
    super.key,
    required this.number,
    required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: TextStyles.boldHeading24,
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyles.regularBody16,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';

class InfoTitle extends StatelessWidget {
  final String title;

  const InfoTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.s17MediumText,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

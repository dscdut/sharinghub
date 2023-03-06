import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';

class TitleInfoProfile extends StatelessWidget {
  final String title;

  final Widget heightSpace;

  const TitleInfoProfile({
    super.key,
    required this.title,
    required this.heightSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.s17MediumText.copyWith(color: Colors.black),
        ),
        heightSpace,
        const Divider(
          color: Color(0xFFABB0BC),
          thickness: 1,
        ),
        heightSpace,
      ],
    );
  }
}

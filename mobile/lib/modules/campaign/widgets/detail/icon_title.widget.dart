import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class IconTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final double? iconSize;

  const IconTitle({
    super.key,
    required this.icon,
    required this.title,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: iconSize,
          color: ColorStyles.zodiacBlue,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyles.s14RegularText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

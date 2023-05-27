import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';

class ItemProfileCampaignWidget extends StatelessWidget {
  const ItemProfileCampaignWidget({
    super.key,
    required this.icon,
    required this.subTitle,
    required this.title,
  });

  final String icon;
  final String subTitle;
  final String title;

  final Widget _verticalSpacing = const SizedBox(
    height: 4,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 25,
            height: 35,
            colorFilter: const ColorFilter.mode(
              ColorStyles.gray300,
              BlendMode.srcIn,
            ),
          ),
          _verticalSpacing,
          Text(
            title,
            style: TextStyles.s14MediumText,
          ),
          _verticalSpacing,
          Text(
            subTitle,
            style: TextStyles.s14RegularText,
          ),
        ],
      ),
    );
  }
}

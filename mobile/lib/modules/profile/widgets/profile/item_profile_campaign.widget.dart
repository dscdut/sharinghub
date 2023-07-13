import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ItemProfileCampaignWidget extends StatelessWidget {
  const ItemProfileCampaignWidget({
    super.key,
    required this.icon,
    required this.subTitle,
    required this.title,
    required this.onTap,
  });

  final String icon;
  final String subTitle;
  final String title;
  final Function()? onTap;

  final Widget _verticalSpacing = const SizedBox(
    height: 4,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.pendingCampaign,
        );
      },
      child: Column(
        children: [
          Text(
            subTitle,
            style: TextStyles.regularHeading34.copyWith(
              color: ColorStyles.primary1,
              fontWeight: FontWeight.bold,
            ),
          ),
          _verticalSpacing,
          Text(
            title,
            style: TextStyles.s14MediumText,
          ),
          _verticalSpacing,
        ],
      ),
    );
  }
}

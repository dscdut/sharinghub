import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class HeaderProfile extends StatelessWidget {
  final double rating;
  final OrganizationModel organization;

  const HeaderProfile({
    super.key,
    required this.rating,
    required this.organization,
  });

  final Widget horizontalSpacing = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.network(
              organization.avatar!,
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
          ),
          horizontalSpacing,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  organization.name,
                  style: TextStyles.s17MediumText
                      .copyWith(color: ColorStyles.zodiacBlue),
                ),
                Row(
                  children: [
                    Text(
                      LocaleKeys.profile_rate.tr(),
                      style: TextStyles.s17MediumText,
                    ),
                    StarRating(rating: rating),
                  ],
                ),
              ],
            ),
          ),
          horizontalSpacing,
          const Icon(
            Icons.chat_outlined,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

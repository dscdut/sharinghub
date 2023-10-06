import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

class OrganizationInfo extends StatelessWidget {
  final OrganizationModel organization;

  const OrganizationInfo({
    super.key,
    required this.organization,
  });

  final _imageHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: organization.avatar == null
                ? Assets.images.imgDefautAvatar.image(
                    fit: BoxFit.cover,
                    width: _imageHeight,
                    height: _imageHeight,
                  )
                : Image.network(
                    organization.avatar!,
                    fit: BoxFit.cover,
                    width: _imageHeight,
                    height: _imageHeight,
                  ),
          ),
          const VerticalDivider(
            width: 8,
            color: Colors.transparent,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  organization.name,
                  style: TextStyles.boldBody16
                      .copyWith(color: ColorStyles.primary1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(
                  height: 4,
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Text(
                      '${LocaleKeys.texts_rate.tr()}: ',
                      style: TextStyles.regularBody14,
                    ),
                    const StarRating(
                      rating: 4,
                      size: 16,
                      color: ColorStyles.zodiacBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.message_outlined,
            color: ColorStyles.zodiacBlue,
            size: 18,
          ),
        ],
      ),
    );
  }
}

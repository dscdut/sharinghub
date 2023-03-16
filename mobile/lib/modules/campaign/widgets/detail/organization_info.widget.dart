import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/info_card.widget.dart';

// TODO: replace that to header profile
class OrganizationInfo extends StatelessWidget {
  final OrganizationModel organization;

  const OrganizationInfo({
    super.key,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Row(
        children: [
          ClipRRect(
            child: Image.network(
              organization.avatar!,
              fit: BoxFit.cover,
              width: 70,
              height: 70,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  organization.name,
                  style: TextStyles.s14MediumText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${LocaleKeys.texts_rate.tr()}: ',
                    ),
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow,
                    )
                  ],
                )
              ],
            ),
          ),
          const Icon(
            Icons.message_outlined,
            color: ColorStyles.zodiacBlue,
            size: 18,
          )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class HeaderProfile extends StatelessWidget {
  final double rating;
  final OrganizationModel organization;
  final Widget widthSpace = const SizedBox(width: 20);

  const HeaderProfile({
    super.key,
    required this.rating,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: Image.network(organization.avatar!).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              widthSpace,
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      organization.name,
                      style: TextStyles.s17MediumText
                          .copyWith(color: const Color(0xFF8EC3B0)),
                    ),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.profile_rate.tr(),
                          style: TextStyles.s17MediumText
                              .copyWith(color: Colors.black),
                        ),
                        StarRating(rating: rating),
                      ],
                    ),
                  ],
                ),
              ),
              widthSpace,
              const Icon(
                Icons.chat_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

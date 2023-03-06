import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/star_rating.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class ProfileHeader extends StatelessWidget {
  final double rating;
  final Widget widthSpace = const SizedBox(width: 20);

  const ProfileHeader({
    super.key,
    required this.rating,
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
                    image: Image.network(
                      'https://images.unsplash.com/photo-1634896941598-b6b500a502a7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=756&q=80',
                    ).image,
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
                      'Trường Đại học Bách Khoa - Đại học Đà Nẵng',
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

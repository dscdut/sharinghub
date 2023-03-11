import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/contact_information.widget.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/title_info_profile.widget.dart';

class BodyProfile extends StatelessWidget {
  final Widget heightSpace;
  final OrganizationModel organization;

  const BodyProfile({
    super.key,
    required this.organization,
    required this.heightSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heightSpace,
        Text(
          organization.description!,
          style: TextStyles.s14RegularText,
          textAlign: TextAlign.justify,
        ),
        const Divider(),
        ContactInformation(
          organization: organization,
        ),
        const Divider(),
        InfoTitle(
          title: LocaleKeys.profile_reviews.tr(),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/icon_title.widget.dart';
import 'package:mobile/modules/profile/widgets/organization_profile/title_info_profile.widget.dart';

class ContactInformation extends StatelessWidget {
  final OrganizationModel organization;

  const ContactInformation({
    super.key,
    required this.organization,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoTitle(
          title: LocaleKeys.profile_contact_info.tr(),
        ),
        IconTitle(icon: Icons.fmd_good_outlined, title: organization.address),
        const SizedBox(
          height: 5,
        ),
        IconTitle(icon: Icons.call_rounded, title: organization.phoneNumber),
      ],
    );
  }
}

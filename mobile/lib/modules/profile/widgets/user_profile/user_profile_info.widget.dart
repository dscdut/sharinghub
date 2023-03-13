import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class UserProfileInfoWidget extends StatelessWidget {
  const UserProfileInfoWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.alternate_email_rounded),
            title: Text(
              user.email,
              style: TextStyles.regularBody16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(
              user.phoneNumber ?? '',
              style: TextStyles.regularBody16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              user.address ?? '',
              style: TextStyles.regularBody16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              user.birthDay == null
                  ? ''
                  : user.birthDay.toString().substring(0, 10),
              style: TextStyles.regularBody16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              user.gender == true ? Icons.male : Icons.female,
            ),
            title: Text(
              user.gender == true
                  ? LocaleKeys.profile_gender_male.tr()
                  : LocaleKeys.profile_gender_female.tr(),
              style: TextStyles.regularBody16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: Text(
              user.school ?? '',
              style: TextStyles.regularBody16,
            ),
          ),
        ],
      ),
    );
  }
}

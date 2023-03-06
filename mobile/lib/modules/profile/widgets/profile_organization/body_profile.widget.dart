import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/widgets/profile_organization/title_info_profile.widget.dart';

class ProfileBody extends StatelessWidget {
  final Widget heightSpace;

  const ProfileBody({
    super.key,
    required this.heightSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        heightSpace,
        Text(
          LocaleKeys.texts_organization_description.tr(),
          style: TextStyles.s14MediumText.copyWith(color: Colors.black),
          textAlign: TextAlign.justify,
        ),
        heightSpace,
        ProfileTitleInfo(
          title: LocaleKeys.profile_contact_info.tr(),
          heightSpace: heightSpace,
        ),
        ProfileTitleInfo(
          title: LocaleKeys.profile_campaigns_doing.tr(),
          heightSpace: heightSpace,
        ),
        ProfileTitleInfo(
          title: LocaleKeys.profile_campaigns_done.tr(),
          heightSpace: heightSpace,
        ),
        ProfileTitleInfo(
          title: LocaleKeys.profile_comments.tr(),
          heightSpace: heightSpace,
        ),
      ],
    );
  }
}

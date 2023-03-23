
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/common/widgets/rounded_icon_button.widget.dart';

class OrganizationManagementAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrganizationManagementAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: LocaleKeys.organization_management.tr(),
      titleColor: ColorStyles.zodiacBlue,
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: const [
        RoundedIconButton(icon: Icons.search),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

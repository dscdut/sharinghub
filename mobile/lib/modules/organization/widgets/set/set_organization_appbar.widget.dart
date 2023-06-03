import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/common/widgets/rounded_icon_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class SetOrganizationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isUpdate;

  const SetOrganizationAppbar({
    super.key,
    this.isUpdate = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: isUpdate
          ? LocaleKeys.profile_organization.tr()
          : LocaleKeys.organization_create.tr(),
      elevation: 0.5,
      actions: const [
        RoundedIconButton(
          icon: Icons.done_rounded,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

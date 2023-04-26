import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/common/widgets/rounded_icon_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class SetUserAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isUpdate;

  const SetUserAppbar({
    super.key,
    this.isUpdate = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: isUpdate
          ? LocaleKeys.profile_personal.tr()
          : LocaleKeys.organization_create.tr(),
      backgroundColor: Colors.white,
      titleColor: ColorStyles.zodiacBlue,
      elevation: 0.5,
      actions: const [
        RoundedIconButton(
          icon: Icons.done_rounded,
          backgroundColor: Colors.transparent,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

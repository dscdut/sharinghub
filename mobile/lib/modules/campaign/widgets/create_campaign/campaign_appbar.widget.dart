import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class CampaignAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isUpdate;

  const CampaignAppBar({
    super.key,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        isUpdate
            ? LocaleKeys.campaign_update.tr()
            : LocaleKeys.campaign_create.tr(),
        style: TextStyles.mediumText.copyWith(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      leading: BackButton(
        color: const Color(0xFF62877A),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: const Color(0xFFDEF5E5),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

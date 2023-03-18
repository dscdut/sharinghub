import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class CampaignAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isUpdate;

  const CampaignAppBar({
    super.key,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: isUpdate
          ? LocaleKeys.campaign_update.tr()
          : LocaleKeys.campaign_create.tr(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

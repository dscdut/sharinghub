import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/widgets/detail/icon_title.widget.dart';

class CampaignDetailAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String campaignName;

  const CampaignDetailAppbar({
    super.key,
    required this.campaignName,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: campaignName,
      elevation: 1,
      actions: [
        PopupMenuButton(
          icon: const Icon(
            Icons.more_vert_rounded,
            color: ColorStyles.primary1,
          ),
          itemBuilder: (_) {
            return <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: IconTitle(
                  icon: Icons.edit,
                  iconSize: 20,
                  title: LocaleKeys.texts_edit.tr(),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: IconTitle(
                  icon: Icons.delete,
                  iconSize: 20,
                  title: LocaleKeys.texts_delele.tr(),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

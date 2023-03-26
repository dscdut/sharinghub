import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/router/app_routes.dart';

class MapSearchButtonWidget extends StatelessWidget {
  const MapSearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: AppRoundedButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
        backgroundColor: ColorStyles.primary1,
        content: LocaleKeys.home_search.tr(),
        width: double.infinity,
        borderRadius: 12,
        prefixIcon: Assets.icons.icSearch.image(
          height: 24,
        ),
      ),
    );
  }
}

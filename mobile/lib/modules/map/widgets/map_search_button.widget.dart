import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/configs/router/app_routes.dart';

class MapSearchButtonWidget extends StatelessWidget {
  const MapSearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: AppRoundedButton(
          width: double.infinity,
          onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          backgroundColor: Colors.white,
          textStyle: TextStyles.regularBody14.copyWith(
            color: ColorStyles.zodiacBlue,
          ),
          content: LocaleKeys.home_enter_keyword.tr(),
          borderRadius: 15,
          prefixIcon: Assets.icons.icSearchDark.image(
            height: 24,
          ),
        ),
      ),
    );
  }
}

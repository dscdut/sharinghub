import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/configs/router/app_routes.dart';

class AuthNavigateOption extends StatelessWidget {
  final bool haveAccount;

  const AuthNavigateOption({
    super.key,
    this.haveAccount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 1.2,
        ),
        Text(
          haveAccount
              ? LocaleKeys.auth_already_have_account.tr()
              : LocaleKeys.auth_have_not_account.tr(),
          style: TextStyles.regularText.copyWith(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            if (haveAccount) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
            } else {
              Navigator.of(context).pushNamed(
                AppRoutes.register,
              );
            }
          },
          child: Text(
            haveAccount
                ? LocaleKeys.auth_login.tr()
                : LocaleKeys.auth_sign_up.tr(),
            style: TextStyles.mediumText
                .copyWith(fontSize: 16, color: ColorStyles.primary1),
          ),
        ),
      ],
    );
  }
}

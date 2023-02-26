import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';

class OptionsAndSubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool isLogin;
  final bool isLoading;

  const OptionsAndSubmitButton({
    super.key,
    this.isLogin = true,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isLogin) const SizedBox(height: 10),
        if (isLogin)
          Text(
            LocaleKeys.auth_forgot_password.tr(),
            style: TextStyles.mediumText.copyWith(
              color: ColorStyles.red500,
            ),
          ),
        const SizedBox(height: 20),
        AppRoundedButton(
          onPressed: onSubmit,
          content: isLogin
              ? LocaleKeys.auth_login.tr()
              : LocaleKeys.auth_sign_up.tr(),
          width: double.infinity,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

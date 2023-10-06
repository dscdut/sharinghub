import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/widgets/choose_role/description_choose_role.widget.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ChooseRoleView extends StatelessWidget {
  const ChooseRoleView({super.key});

  void _navigateToRegister(BuildContext context, bool isPersonal) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.register,
      (_) => false,
      arguments: isPersonal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSize.horizontalSpace,
              ),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.texts_register.tr(),
                    style: TextStyles.boldText.copyWith(fontSize: 34),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DescriptionChooseRole(
                    description: LocaleKeys.texts_personal_description.tr(),
                    buttonContent: LocaleKeys.texts_personal.tr(),
                    onPressed: () {
                      _navigateToRegister(context, true);
                    },
                  ),
                  DescriptionChooseRole(
                    description: LocaleKeys.texts_organization_description.tr(),
                    buttonContent: LocaleKeys.texts_organization.tr(),
                    onPressed: () {
                      _navigateToRegister(context, false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

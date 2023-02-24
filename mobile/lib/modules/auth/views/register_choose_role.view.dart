import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/router/app_routes.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

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
                    height: 43,
                  ),
                  Text(
                    LocaleKeys.texts_lorem.tr(),
                    style: TextStyles.s14RegularText,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(38),
                    child: AppRoundedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerPersonal);
                      },
                      content: LocaleKeys.texts_personal.tr(),
                      borderRadius: 10,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    LocaleKeys.texts_lorem.tr(),
                    style: TextStyles.s14RegularText,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(38),
                    child: AppRoundedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.registerOrganization);
                      },
                      content: LocaleKeys.texts_organization.tr(),
                      borderRadius: 10,
                      width: double.infinity,
                    ),
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

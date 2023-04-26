import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/router/app_routes.dart';

class SummaryInfo extends StatelessWidget {
  const SummaryInfo({super.key});

  String? _getAvatarUrl(UserModel user) {
    return user.isOrganizationMode
        ? user.currentOrganization!.avatar
        : user.avatar;
  }

  String _getTitle(UserModel user) {
    return user.isOrganizationMode
        ? user.currentOrganization!.name
        : user.fullName;
  }

  String _getSubTitle(UserModel user) {
    return user.isOrganizationMode
        ? LocaleKeys.profile_organization.tr()
        : LocaleKeys.profile_personal.tr();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.user != current.user &&
          current.status != AuthenticationStatus.unauthenticated,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.status.isAuthenticatedOrganization) {
              Navigator.of(context).pushNamed(
                AppRoutes.setOrganization,
                arguments: ArgumentWrapper2(
                  param1: state.user!.currentOrganization,
                  param2: null,
                ),
              );
            } else {
              Navigator.of(context).pushNamed(
                AppRoutes.setIndividual,
                arguments: state.user,
              );
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: _getAvatarUrl(state.user!) == null
                    ? Assets.images.imgDefautAvatar.image(
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        _getAvatarUrl(state.user!)!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitle(state.user!),
                    style: TextStyles.s17MediumText,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    _getSubTitle(state.user!),
                    style: TextStyles.s14RegularText,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

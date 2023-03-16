import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/core/bloc/root.bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int newIndex) {
              context
                  .read<RootBloc>()
                  .add(RootBottomTabChange(newIndex: newIndex));
            },
            selectedItemColor: ColorStyles.blue300,
            unselectedItemColor: ColorStyles.gray300,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.fmd_good_outlined),
                label: LocaleKeys.root_map.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.travel_explore_outlined),
                label: LocaleKeys.root_explore.tr(),
              ),
              if (context
                  .read<AuthBloc>()
                  .state
                  .status
                  .isAuthenticatedOrganization)
                BottomNavigationBarItem(
                  icon: const Icon(Icons.manage_search_outlined),
                  label: LocaleKeys.root_management.tr(),
                ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications_outlined),
                label: LocaleKeys.texts_notification.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                label: LocaleKeys.root_profile.tr(),
              )
            ],
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
    );
  }
}

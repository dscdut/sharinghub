import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/core/bloc/root.bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  final double _iconSize = 24;

  bool _isAuthenticatedOrganization(BuildContext context) =>
      context.read<AuthBloc>().state.status.isAuthenticatedOrganization;

  ColorFilter? _getColorFilter(bool isSelected) {
    if (isSelected) {
      return const ColorFilter.mode(
        ColorStyles.primary1,
        BlendMode.srcIn,
      );
    } else {
      return const ColorFilter.mode(
        ColorStyles.disableColor,
        BlendMode.srcIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: BlocBuilder<RootBloc, RootState>(
        builder: (context, state) {
          return DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 25,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state.currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (int newIndex) {
                  context
                      .read<RootBloc>()
                      .add(RootBottomTabChange(newIndex: newIndex));
                },
                selectedFontSize: 11,
                unselectedFontSize: 11,
                selectedLabelStyle: const TextStyle(
                  height: 2,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  height: 2,
                  fontWeight: FontWeight.w700,
                ),
                selectedItemColor: ColorStyles.primary1,
                unselectedItemColor: ColorStyles.disableColor,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Assets.icons.bottomNavigation.maps.svg(
                      height: _iconSize,
                      width: _iconSize,
                      colorFilter: _getColorFilter(state.currentIndex == 0),
                    ),
                    label: LocaleKeys.root_map.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.bottomNavigation.explore.svg(
                      height: _iconSize,
                      width: _iconSize,
                      colorFilter: _getColorFilter(state.currentIndex == 1),
                    ),
                    label: LocaleKeys.root_explore.tr(),
                  ),
                  if (_isAuthenticatedOrganization(context))
                    BottomNavigationBarItem(
                      icon: Assets.icons.bottomNavigation.myCampaigns.svg(
                        height: _iconSize,
                        width: _iconSize,
                        colorFilter: _getColorFilter(state.currentIndex == 2),
                      ),
                      label: LocaleKeys.root_management.tr(),
                    ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.bottomNavigation.notifications.svg(
                      height: _iconSize,
                      width: _iconSize,
                      colorFilter: _getColorFilter(
                        !_isAuthenticatedOrganization(context) &&
                                state.currentIndex == 2 ||
                            _isAuthenticatedOrganization(context) &&
                                state.currentIndex == 3,
                      ),
                    ),
                    label: LocaleKeys.texts_notification.tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Assets.icons.bottomNavigation.profile.svg(
                      height: _iconSize,
                      width: _iconSize,
                      colorFilter: _getColorFilter(
                        !_isAuthenticatedOrganization(context) &&
                                state.currentIndex == 3 ||
                            _isAuthenticatedOrganization(context) &&
                                state.currentIndex == 4,
                      ),
                    ),
                    label: LocaleKeys.root_profile.tr(),
                  )
                ],
              ),
            ),
          );
        },
        buildWhen: (previous, current) {
          return previous.currentIndex != current.currentIndex;
        },
      ),
    );
  }
}

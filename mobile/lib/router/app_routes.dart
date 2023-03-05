import 'package:flutter/material.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/view/location_search.view.dart';
import 'package:mobile/modules/core/views/root.view.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/splash/splash.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String chooseRole = '/chooseRole';

  // Campaign
  static const String setCampaign = '/setCampaign';
  static const String campaignDetail = '/campaignDetail';
  static const String locationSearch = '/locationSearch';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Root
  static const String root = '/root';

  // static final router = GoRouter(
  //   routes: [
  //     GoRoute(
  //       path: login,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: LoginPage(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: register,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RegisterView(),
  //         );
  //       },
  //     ),
  //     GoRoute(
  //       path: root,
  //       pageBuilder: (_, __) {
  //         return const MaterialPage(
  //           child: RootPage(),
  //         );
  //       },
  //     )
  //   ],
  //   initialLocation: login,
  // );

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashPage();
          },
        );
      case login:
        return MaterialPageRoute(
          builder: (_) {
            return const LoginPage();
          },
        );
      case chooseRole:
        return MaterialPageRoute(
          builder: (_) {
            return const ChooseRoleView();
          },
        );
      case register:
        final bool isPersonal = settings.arguments as bool;

        return MaterialPageRoute(
          builder: (_) {
            return RegisterPage(
              isPersonal: isPersonal,
            );
          },
        );
      case setCampaign:
        final CampaignModel? campaign = settings.arguments as CampaignModel?;

        return MaterialPageRoute(
          builder: (_) {
            return SetCampaignPage(
              campaign: campaign,
            );
          },
        );
      case campaignDetail:
        return MaterialPageRoute(
          builder: (_) {
            return CampaignDetailPage(
              campaign: settings.arguments as CampaignModel,
            );
          },
        );
      case locationSearch:
        return MaterialPageRoute(
          builder: (_) {
            return const LocationSearchPage();
          },
        );
      case root:
        return MaterialPageRoute(
          builder: (_) {
            return const RootPage();
          },
        );
      default:
        return null;
    }
  }
}

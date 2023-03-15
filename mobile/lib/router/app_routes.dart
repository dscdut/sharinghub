import 'package:flutter/material.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/view/campaign_register.view.dart';
import 'package:mobile/modules/campaign/view/location_search.view.dart';
import 'package:mobile/modules/core/views/root.view.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/explore/view/explore.view.dart';
import 'package:mobile/modules/management/management.dart';
import 'package:mobile/modules/profile/profile.dart';
import 'package:mobile/modules/profile/view/user_profile.view.dart';
import 'package:mobile/modules/splash/splash.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String chooseRole = '/chooseRole';

  static const String search = '/search';

  //Profile
  static const String organizationProfile = '/organizationProfile';
  static const String userProfile = '/userProfile';

  // Campaign
  static const String setCampaign = '/setCampaign';
  static const String campaignRegister = '/campaignRegister';
  static const String campaignDetail = '/campaignDetail';
  static const String locationSearch = '/locationSearch';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Feedback
  static const String organizationFeedback = '/organizationFeedback';

  // Root
  static const String root = '/root';

  // Organization
  static const String setOrganization = '/setOrganization';

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
        return MaterialPageRoute(
          builder: (_) {
            return const RegisterPage();
          },
        );
      case organizationProfile:
        return MaterialPageRoute(
          builder: (_) {
            return OrganizationProfilePage(
              organization: settings.arguments as OrganizationModel,
            );
          },
        );
      case organizationFeedback:
        return MaterialPageRoute(
          builder: (_) {
            return FeedbackCampaignPage(
              campaign: settings.arguments as CampaignModel,
            );
          },
        );
      case userProfile:
        return MaterialPageRoute(
          builder: (_) {
            return const UserProfilePage();
          },
        );
      case setCampaign:
        return MaterialPageRoute(
          builder: (_) {
            return SetCampaignPage(
              campaign: settings.arguments as CampaignModel?,
            );
          },
        );

      case campaignRegister:
        return MaterialPageRoute(
          builder: (_) {
            return CampaignRegisterFormPage(
              formLink: settings.arguments as String,
            );
          },
        );
      case search:
        return MaterialPageRoute(
          builder: (_) {
            return const ExplorePage();
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
      case setOrganization:
        return MaterialPageRoute(
          builder: (_) {
            return const SetOrganizationPage();
          },
        );
      default:
        return null;
    }
  }
}

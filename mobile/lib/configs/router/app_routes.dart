import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/models/organization.model.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/view/donors/campaign_donors.view.dart';
import 'package:mobile/modules/campaign/view/set/location_search.view.dart';
import 'package:mobile/modules/core/views/root.view.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/explore/explore.dart';
import 'package:mobile/modules/organization/management.dart';
import 'package:mobile/modules/profile/profile.dart';
import 'package:mobile/modules/profile/view/set_user_profile.view.dart';
import 'package:mobile/modules/profile/view/user_profile.view.dart';
import 'package:mobile/modules/splash/splash.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String chooseRole = '/chooseRole';

  static const String search = '/search';

  //Profile
  static const String organizationProfile = '/organizationProfile';
  static const String userProfile = '/userProfile';
  static const String setIndividual = '/setIndividual';

  // Campaign
  static const String setCampaign = '/setCampaign';
  static const String campaignRegister = '/campaignRegister';
  static const String campaignDetail = '/campaignDetail';
  static const String locationSearch = '/locationSearch';
  static const String campaignDonation = '/campaignDonation';
  static const String donate = '/donate';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Feedback
  static const String organizationFeedback = '/organizationFeedback';
  static const String participantFeedback = '/participantFeedback';

  // Root
  static const String root = '/root';

  // Organization
  static const String organizationManagement = '/organizationManagement';
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
            return OrganizationFeedbackPage(
              campaign: settings.arguments as CampaignModel,
            );
          },
        );
      case participantFeedback:
        return MaterialPageRoute(
          builder: (_) {
            return ParticipantFeedbackPage(
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
      case setIndividual:
        return MaterialPageRoute(
          builder: (_) {
            return SetUserPage(
              user: settings.arguments as UserModel,
            );
          },
        );
      case setCampaign:
        final argumentWrapper = settings.arguments as ArgumentWrapper3<
            CampaignModel?, CampaignManagementBloc, AuthBloc>;

        return MaterialPageRoute(
          builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: argumentWrapper.param2,
                ),
                BlocProvider.value(
                  value: argumentWrapper.param3,
                )
              ],
              child: SetCampaignPage(
                campaign: argumentWrapper.param1,
              ),
            );
          },
        );
      case campaignRegister:
        return MaterialPageRoute(
          builder: (_) {
            return CampaignRegisterFormPage(
              campaign: settings.arguments as CampaignModel,
            );
          },
        );
      case search:
        return MaterialPageRoute(
          builder: (_) {
            return const SearchPage();
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
      case donate:
        return MaterialPageRoute(
          builder: (_) {
            return DonatePage(
              campaignId: settings.arguments as int,
            );
          },
        );
      case campaignDonation:
        return MaterialPageRoute(
          builder: (_) => CampaignDonorsPage(
            initIndex: settings.arguments as int,
          ),
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
      case organizationManagement:
        return MaterialPageRoute(
          builder: (_) {
            return const OrganizationManagementPage();
          },
        );
      case setOrganization:
        final argumentWrapper = settings.arguments as ArgumentWrapper2<
            OrganizationModel?, OrganizationManagementBloc?>;

        return MaterialPageRoute(
          builder: (_) {
            final page = SetOrganizationPage(
              organization: argumentWrapper.param1,
            );

            return argumentWrapper.param2 == null
                ? page
                : BlocProvider.value(
                    value: argumentWrapper.param2!,
                    child: page,
                  );
          },
        );

      default:
        return null;
    }
  }
}

class ArgumentWrapper2<A, B> {
  ArgumentWrapper2({
    required this.param1,
    required this.param2,
  });

  final A param1;
  final B param2;
}

class ArgumentWrapper3<A, B, C> {
  ArgumentWrapper3({
    required this.param1,
    required this.param2,
    required this.param3,
  });

  final A param1;
  final B param2;
  final C param3;
}

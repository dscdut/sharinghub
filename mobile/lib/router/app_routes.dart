import 'package:flutter/material.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/auth/views/register_choose_role.view.dart';
import 'package:mobile/modules/auth/views/register_organization.view.dart';
import 'package:mobile/modules/core/views/root.view.dart';
import 'package:mobile/modules/splash/splash.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String chooseRole = '/chooseRole';

  // Auth
  static const String login = '/login';
  static const String registerPersonal = '/registerPersonal';
  static const String registerOrganization = '/registerOrganization';

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
            return const ChooseRolePage();
          },
        );
      case registerPersonal:
        return MaterialPageRoute(
          builder: (_) {
            return const PersonalRegisterPage();
          },
        );
      case registerOrganization:
        return MaterialPageRoute(
          builder: (_) {
            return const OrganizationRegisterPage();
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

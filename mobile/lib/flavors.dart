import 'package:mobile/common/constants/env_keys.dart';

enum Flavor {
  DEV,
  QA,
  STAGING,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get googleMapApiKey =>
      const String.fromEnvironment(EnvKeys.googleMapApiKey);

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Flutter Template DEV';
      case Flavor.QA:
        return 'Flutter Template QA';
      case Flavor.STAGING:
        return 'Flutter Template';
      default:
        return 'title';
    }
  }

  static String get apiBaseUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return const String.fromEnvironment(EnvKeys.baseUrl);
      case Flavor.QA:
        return const String.fromEnvironment(EnvKeys.baseUrl);
      case Flavor.STAGING:
        return const String.fromEnvironment(EnvKeys.baseUrl);
      default:
        return const String.fromEnvironment(EnvKeys.baseUrl);
    }
  }
}

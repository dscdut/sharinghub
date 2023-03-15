enum Flavor {
  DEV,
  QA,
  STAGING,
}

class AppFlavor {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

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
        return 'https://sharing-hub.gdsc.dev';
      case Flavor.QA:
        return 'https://sharing-hub.gdsc.dev';
      case Flavor.STAGING:
        return 'https://sharing-hub.gdsc.dev';
      default:
        return 'https://sharing-hub.gdsc.dev';
    }
  }
}

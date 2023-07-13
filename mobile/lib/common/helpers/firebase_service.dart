import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/generated/firebase_options/firebase_options_dev.dart'
    as firebase_option_dev;
import 'package:mobile/generated/firebase_options/firebase_options_qa.dart'
    as firebase_option_qa;
import 'package:mobile/generated/firebase_options/firebase_options_staging.dart'
    as firebase_option_staging;

abstract class FirebaseService {
  static FirebaseAnalytics analytic = FirebaseAnalytics.instance;

  static FirebaseOptions _getFirebaseOptions() {
    switch (AppFlavor.appFlavor) {
      case Flavor.QA:
        return firebase_option_qa.DefaultFirebaseOptions.currentPlatform;
      case Flavor.STAGING:
        return firebase_option_staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.DEV:
      default:
        return firebase_option_dev.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: _getFirebaseOptions(),
    );

    await _initAnalytic();
  }

  static Future<void> _initAnalytic() async {
    await analytic.setAnalyticsCollectionEnabled(true);
  }
}

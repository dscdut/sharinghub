import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/generated/firebase_options/firebase_options_dev.dart'
    as FirebaseOptionDev;
import 'package:mobile/generated/firebase_options/firebase_options_qa.dart'
    as FirebaseOptionQA;
import 'package:mobile/generated/firebase_options/firebase_options_staging.dart'
    as FirebaseOptionStaging;

abstract class FirebaseService {
  static FirebaseAnalytics analytic = FirebaseAnalytics.instance;

  static FirebaseOptions _getFirebaseOptions() {
    switch (AppFlavor.appFlavor) {
      case Flavor.QA:
        return FirebaseOptionQA.DefaultFirebaseOptions.currentPlatform;
      case Flavor.STAGING:
        return FirebaseOptionStaging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.DEV:
      default:
        return FirebaseOptionDev.DefaultFirebaseOptions.currentPlatform;
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

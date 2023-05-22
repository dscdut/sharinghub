import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:mobile/app.dart';
import 'package:mobile/common/helpers/firebase_service.dart';
import 'package:mobile/configs/app_bloc_observer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/generated/codegen_loader.g.dart';

Future<void> mainApp(Flavor flavor) async {
  AppFlavor.appFlavor = flavor;

  runZonedGuarded<Future<void>>(
    () async {
      await initializeApp();

      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          path: 'assets/locales',
          fallbackLocale: const Locale('en', 'US'),
          // startLocale: const Locale('vi', 'VN'),
          useOnlyLangCode: true,
          assetLoader: const CodegenLoader(),
          child: const MyApp(),
        ),
      );
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await Hive.initFlutter();

  await configureDependencies();

  await FirebaseService.init();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  handleError();

  Bloc.observer = AppBlocObserver();
}

void handleError() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/router/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/flavors.dart';
import 'package:mobile/generated/codegen_loader.g.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log(
      'onBlocCreate -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CREATE',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onAddEvent -- $event', name: '${bloc.runtimeType}_EVENT');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      'onStateTransition -- ${bloc.runtimeType}\n',
      name: '${bloc.runtimeType}_TRANSITION',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      'onError -- ${bloc.runtimeType}, $error',
      name: '${bloc.runtimeType}_ERROR',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log(
      'onBlocClose -- ${bloc.runtimeType}',
      name: '${bloc.runtimeType}_CLOSE',
    );
  }
}

Future<void> mainApp(Flavor flavor) async {
  AppFlavor.appFlavor = flavor;
  WidgetsFlutterBinding.ensureInitialized();
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
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userRepository: getIt.get<UserRepository>(),
      ),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // routerConfig: AppRoutes.router,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: AppRoutes.splash,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          builder: (_, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (_, state) {
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    break;
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.root,
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.root,
                      (route) => false,
                    );
                    break;
                }
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  configureDependencies();

  await Hive.initFlutter();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }

  Bloc.observer = AppBlocObserver();
}

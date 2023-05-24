import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/configs/router/app_routes.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/auth/auth.dart';

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
            fontFamily: 'BeVietnamPro',
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
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (_, state) {
                switch (state.status) {
                  case AuthenticationStatus.unknown:
                    break;
                  case AuthenticationStatus.authenticatedOrganization:
                  case AuthenticationStatus.authenticatedUser:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.root,
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil(
                      AppRoutes.login,
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

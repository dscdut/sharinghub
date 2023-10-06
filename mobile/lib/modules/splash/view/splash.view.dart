import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';
import 'package:mobile/modules/splash/bloc/splash.bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        authBloc: context.read<AuthBloc>(),
      ),
      lazy: false,
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Assets.images.imgLogo.image(
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'SharingHub',
              style: TextStyles.boldBody16.copyWith(fontSize: 30),
            ),
            const Spacer(),
            const Text(
              'Powered by GDSC-DUT',
              style: TextStyles.s14RegularText,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

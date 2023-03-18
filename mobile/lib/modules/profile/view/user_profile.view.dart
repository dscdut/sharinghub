import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/common/widgets/rounded_icon_button.widget.dart';
import 'package:mobile/modules/profile/bloc/user_profile/user_profile.bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileBloc(
        userRepository: getIt.get<UserRepository>(),
      ),
      child: BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) => _listenOnChange(context, state),
        child: const _UserProfileView(),
      ),
    );
  }

  void _listenOnChange(
    BuildContext context,
    UserProfileState bloc,
  ) {}
}

class _UserProfileView extends StatelessWidget {
  const _UserProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.profile_personal.tr(),
        titleColor: ColorStyles.zodiacBlue,
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: const [
          RoundedIconButton(icon: Icons.done),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: const SizedBox(),
      backgroundColor: Colors.white,
    );
  }
}

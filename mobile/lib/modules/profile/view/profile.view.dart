import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/profile/widgets/profile/list_status_shimmer.widget.dart';
import 'package:mobile/modules/profile/bloc/profile/profile.bloc.dart';
import 'package:mobile/modules/profile/widgets/profile/list_setting_item.widget.dart';
import 'package:mobile/modules/profile/widgets/profile/summary_info.widget.dart';
import 'package:mobile/modules/profile/widgets/profile/summary_info_shimmer.widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(
        userRepository: getIt.get<UserRepository>(),
        authBloc: context.read<AuthBloc>(),
      ),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  final Widget _verticalSpacing = const SizedBox(
    height: 20,
  );

  dynamic _getProfileModel(BuildContext context) {
    final UserModel userInfo = context.read<ProfileBloc>().state.user!;

    return userInfo.currentOrganization ?? userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.horizontalSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SummaryInfo(),
              const Divider(
                color: ColorStyles.gray300,
                height: 40,
              ),
              const ListStatus(),
              _verticalSpacing,
              const ListSettingItem(),
            ],
          ),
        ),
      ),
    );
  }
}

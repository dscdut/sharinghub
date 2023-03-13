import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/bloc/user_profile/user_profile.bloc.dart';
import 'package:mobile/modules/profile/widgets/user_profile/user_profile_info.widget.dart';

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
      appBar: AppBar(
        title: Text(LocaleKeys.profile_profile.tr()),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: state.user?.avatar == null
                          ? Assets.images.imgDefautAvatar.image(
                              height: double.infinity,
                            )
                          : Image.network(
                              state.user!.avatar!,
                              height: double.infinity,
                            ),
                    ),
                    title: Text(
                      state.user?.fullName ?? '',
                      style: TextStyles.boldHeading20,
                    ),
                    subtitle: Text(
                      "@${state.user?.id.toString() ?? ''}",
                      style:
                          TextStyles.regularBody14.copyWith(color: Colors.grey),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  UserProfileInfoWidget(user: state.user!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

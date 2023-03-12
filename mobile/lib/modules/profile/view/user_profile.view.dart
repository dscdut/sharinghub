import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
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
      appBar: AppBar(
        title: const Text('User Profile'),
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
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<UserProfileBloc>().add(
                      const UserProfileStarted(),
                    );
              },
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: state.user?.avatarURL == null
                          ? Assets.images.imgDefautAvatar.image(
                              height: double.infinity,
                            )
                          : Image.network(
                              state.user!.avatarURL!,
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.alternate_email_rounded),
                          title: Text(
                            state.user?.email ?? '',
                            style: TextStyles.regularBody16,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                            state.user?.phoneNumber ?? '',
                            style: TextStyles.regularBody16,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text(
                            state.user?.address ?? '',
                            style: TextStyles.regularBody16,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            state.user?.birthDay.toString().substring(0, 10) ??
                                '',
                            style: TextStyles.regularBody16,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            state.user?.gender == true
                                ? Icons.male
                                : Icons.female,
                          ),
                          title: Text(
                            state.user?.gender == true ? 'Nam' : 'Nữ',
                            style: TextStyles.regularBody16,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}

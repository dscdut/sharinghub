import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/data/repositories/user.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/bloc/profile.bloc.dart';
import 'package:mobile/modules/profile/widgets/profile/item_profile_campaign.widget.dart';
import 'package:mobile/modules/profile/widgets/profile/item_setting.widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(
        userRepository: getIt.get<UserRepository>(),
      ),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.profile_profile.tr()),
            backgroundColor: Colors.blue,
          ),
          body: Container(
            child: state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              state.user?.name ?? '',
                              style: TextStyles.boldHeading20,
                            ),
                            subtitle: Text(
                              state.user?.email ?? '',
                              style: TextStyles.regularBody16,
                            ),
                          ),
                          const Divider(
                            height: 20,
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemProfileCampaignWidget(
                                number: state.user?.projectPending ?? 0,
                                title: LocaleKeys.profile_pending.tr(),
                              ),
                              ItemProfileCampaignWidget(
                                number: state.user?.projectOnGoing ?? 0,
                                title: LocaleKeys.profile_ongoing.tr(),
                              ),
                              ItemProfileCampaignWidget(
                                number: state.user?.projectCompleted ?? 0,
                                title: LocaleKeys.profile_feedback.tr(),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 50,
                            color: Colors.transparent,
                          ),
                          Text(
                            LocaleKeys.profile_preferences.tr(),
                            style: TextStyles.boldSubti18,
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_setting.tr(),
                            icon: Assets.icons.icSetting.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_about_us.tr(),
                            icon: Assets.icons.icStar.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_share_this_app.tr(),
                            icon: Assets.icons.icShare.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_help_center.tr(),
                            icon: Assets.icons.icSupport.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_delete_account.tr(),
                            icon: Assets.icons.icRemoveUser.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_switch_account.tr(),
                            icon: Assets.icons.icSwitch.image(),
                            onTap: () {},
                          ),
                          ItemSettingWidget(
                            title: LocaleKeys.profile_logout.tr(),
                            icon: Assets.icons.icLogout.image(),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

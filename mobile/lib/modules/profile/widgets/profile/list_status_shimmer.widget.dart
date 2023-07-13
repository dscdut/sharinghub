import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/profile/widgets/profile/item_profile_campaign.widget.dart';
import 'package:shimmer/shimmer.dart';

class ListStatus extends StatelessWidget {
  final bool isLoading;

  const ListStatus({super.key, this.isLoading = false});

  final Widget _verticalSpacing = const SizedBox(
    height: 4,
  );

  Widget _getShimmerLoading() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                _verticalSpacing,
                Container(
                  width: 60,
                  height: 10,
                  color: Colors.white,
                ),
                _verticalSpacing,
                Container(
                  width: 40,
                  height: 10,
                  color: Colors.white,
                )
              ],
            ),
          );
        }),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return isLoading
            ? _getShimmerLoading()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemProfileCampaignWidget(
                    icon: Assets.icons.profile.pending.path,
                    subTitle: (state.user?.pendingCampaigns ?? '0').toString(),
                    title: LocaleKeys.profile_pending.tr(),
                    onTap: () {},
                  ),
                  ItemProfileCampaignWidget(
                    icon: Assets.icons.profile.ongoing.path,
                    subTitle: (state.user?.ongoingCampaigns ?? '0').toString(),
                    title: LocaleKeys.profile_participating.tr(),
                    onTap: () {},
                  ),
                  ItemProfileCampaignWidget(
                    icon: Assets.icons.profile.done.path,
                    subTitle: (state.user?.totalFeedbacks ?? '0').toString(),
                    title: LocaleKeys.profile_done.tr(),
                    onTap: () {},
                  ),
                ],
              );
      },
    );
  }
}

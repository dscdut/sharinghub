
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile/generated/assets.gen.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/widgets/profile/item_profile_campaign.widget.dart';
import 'package:shimmer/shimmer.dart';

class ListStatus extends StatelessWidget {
  final bool isLoading;

  const ListStatus({super.key, this.isLoading = false});

  final Widget _verticalSpacing = const SizedBox(
    height: 4,
  );

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemProfileCampaignWidget(
                icon: Assets.icons.profile.pending.path,
                subTitle: LocaleKeys.profile_form_number
                    .tr(namedArgs: {'number': '12'}),
                title: LocaleKeys.profile_pending.tr(),
              ),
              ItemProfileCampaignWidget(
                icon: Assets.icons.profile.ongoing.path,
                subTitle: LocaleKeys.profile_campaign_number
                    .tr(namedArgs: {'number': '12'}),
                title: LocaleKeys.profile_participating.tr(),
              ),
              ItemProfileCampaignWidget(
                icon: Assets.icons.profile.done.path,
                subTitle: LocaleKeys.profile_campaign_number
                    .tr(namedArgs: {'number': '20'}),
                title: LocaleKeys.profile_done.tr(),
              ),
            ],
          );
  }
}

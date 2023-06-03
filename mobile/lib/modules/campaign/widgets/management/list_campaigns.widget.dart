import 'package:flutter/material.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/widgets/avatar_info_card.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/configs/router/app_routes.dart';

class ListCampaigns extends StatelessWidget {
  final List<CampaignModel> campaigns;

  const ListCampaigns({
    super.key,
    required this.campaigns,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(
        AppSize.horizontalSpace,
      ),
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final CampaignModel currentCampaign = campaigns[index];

        return AvatarInfoCard(
          avatar: currentCampaign.image,
          description: currentCampaign.description ?? '',
          title: currentCampaign.name,
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.campaignDetail,
              arguments: currentCampaign,
            );
          },
        );
      },
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 10,
        );
      },
      shrinkWrap: true,
      itemCount: campaigns.length,
    );
  }
}

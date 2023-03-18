import 'package:flutter/material.dart';

import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/map/widgets/campaign_item.widget.dart';

class ListMarkerCampaigns extends StatelessWidget {
  final List<CampaignModel> campaigns;

  const ListMarkerCampaigns({
    super.key,
    required this.campaigns,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final CampaignModel currentCampaign = campaigns[index];

        return CampaignItem(currentCampaign: currentCampaign);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: campaigns.length,
    );
  }
}

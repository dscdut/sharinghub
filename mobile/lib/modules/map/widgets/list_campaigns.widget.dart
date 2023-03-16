import 'package:flutter/material.dart';

import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/map/widgets/campaign_item.widget.dart';

class ListCampaigns extends StatelessWidget {
  final List<CampaignModel> campaigns;

  const ListCampaigns({
    super.key,
    required this.campaigns,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final CampaignModel currentCampaign = campaigns[index];
        return Container(
          color: currentCampaign.isOngoing
              ? Colors.grey.withOpacity(0.2)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: CampaignItem(currentCampaign: currentCampaign),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.transparent,
        height: 0,
      ),
      itemCount: campaigns.length,
    );
  }
}

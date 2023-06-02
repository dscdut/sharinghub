import 'package:flutter/material.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/profile/widgets/pending_campaign/item_pending_campaign.widget.dart';

class ListPendingCampaignsWidet extends StatelessWidget {
  const ListPendingCampaignsWidet({
    super.key,
    required this.campaigns,
  });

  final List<CampaignModel> campaigns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        itemBuilder: (context, index) => ItemPendingCampaignWidget(
          campaign: campaigns[index],
        ),
        separatorBuilder: (context, index) => const Divider(
          height: 32,
          color: Colors.transparent,
        ),
        itemCount: campaigns.length,
      ),
    );
  }
}

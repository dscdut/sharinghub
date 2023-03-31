import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/explore/widgets/explore_item.widget.dart';

import 'package:mobile/common/widgets/common_error.widget.dart';

class ExploreListCampaignWidget extends StatelessWidget {
  const ExploreListCampaignWidget({
    super.key,
    this.campaigns,
    required this.status,
  });

  final List<CampaignModel>? campaigns;
  final HandleStatus status;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (status.isLoading || status.isInitial) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: CupertinoActivityIndicator(),
            ),
          );
        }
        if (status.isSuccess) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                ExploreItem(item: campaigns![index]),
            separatorBuilder: (context, index) => const Divider(
              height: 10,
              color: Colors.transparent,
            ),
            itemCount: campaigns!.length,
          );
        } else {
          return const CommonError();
        }
      },
    );
  }
}

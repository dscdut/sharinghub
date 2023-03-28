import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_detail_donors.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaing_request_join.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_detail_info.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_ended_info.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/image_and_description.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/organization_info.widget.dart';

class CampaignInfo extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignInfo({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10 + context.paddingBottom),
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          ImageAndDescription(
            image: campaign.image!,
            description: campaign.description,
          ),
          const SizedBox(
            height: 10,
          ),
          CampaignDetailInfo(campaign: campaign),
          const SizedBox(
            height: 10,
          ),
          OrganizationInfo(organization: campaign.organization!),
          const SizedBox(
            height: 10,
          ),
          const CampaignDetailDonorsWidget(),
          campaign.isOngoing
              ? BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
                  builder: (context, state) {
                    return CampaignRequestJoin(
                      formLink: campaign.registerLink,
                      artifactTypes: campaign.donationRequirement,
                    );
                  },
                )
              : const CampaignEndedInfo(),
        ],
      ),
    );
  }
}

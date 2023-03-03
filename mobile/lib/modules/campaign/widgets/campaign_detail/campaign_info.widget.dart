import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/campaign_detail_info.widget.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/campaign_ended_info.widget.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/image_and_description.widget.dart';
import 'package:mobile/modules/campaign/widgets/campaign_detail/organization_info.widget.dart';

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
            image: campaign.imageURL!,
            description: campaign.description,
          ),
          const SizedBox(
            height: 10,
          ),
          CampaignDetailInfo(campaign: campaign),
          const SizedBox(
            height: 10,
          ),
          OrganizationInfo(organization: campaign.organization),
          const SizedBox(
            height: 10,
          ),
          campaign.isOngoing
              ? BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
                  builder: (context, state) {
                    return AppRoundedButton(
                      width: double.infinity,
                      onPressed: () {
                        context
                            .read<CampaignDetailBloc>()
                            .add(CampaignDetailJoin());
                      },
                      backgroundColor: ColorStyles.green600,
                      isLoading:
                          state.status == CampaignDetailStatus.joinLoading,
                      content: LocaleKeys.button_join.tr(),
                    );
                  },
                )
              : const CampaignEndedInfo()
        ],
      ),
    );
  }
}

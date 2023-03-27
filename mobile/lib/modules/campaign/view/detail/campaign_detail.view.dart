import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/common_error.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_detail_appbar.widget.dart';
import 'package:mobile/modules/campaign/widgets/detail/campaign_info.widget.dart';

class CampaignDetailPage extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignDetailPage({
    super.key,
    required this.campaign,
  });

  void _listenCampaignDetailStateChanged(
    BuildContext context,
    CampaignDetailState state,
  ) {
    if (state.status == CampaignDetailStatus.joinFailed) {
      ToastUtil.showError(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CampaignDetailBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      )..add(CampaignDetailGet(campaign.id!)),
      child: BlocListener<CampaignDetailBloc, CampaignDetailState>(
        listener: _listenCampaignDetailStateChanged,
        child: _CampaignDetailView(
          campaign: campaign,
        ),
      ),
    );
  }
}

class _CampaignDetailView extends StatelessWidget {
  final CampaignModel campaign;

  const _CampaignDetailView({
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CampaignDetailAppbar(campaignName: campaign.name),
      backgroundColor: Colors.white,
      body: BlocBuilder<CampaignDetailBloc, CampaignDetailState>(
        builder: (context, state) {
          return ConditionalRenderUtil.single(
            context,
            value: state.status,
            caseBuilders: {
              CampaignDetailStatus.getFailed: (_) =>
                  const Center(child: CommonError()),
              CampaignDetailStatus.getLoading: (_) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
              CampaignDetailStatus.initial: (_) => const SizedBox(),
            },
            fallbackBuilder: (_) {
              return CampaignInfo(
                campaign: state.campaignModel!,
              );
            },
          );
        },
      ),
    );
  }
}

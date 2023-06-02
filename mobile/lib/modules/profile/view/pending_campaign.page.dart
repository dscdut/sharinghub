import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/profile/bloc/pending_campaign/pending_campaign_bloc.dart';
import 'package:mobile/modules/profile/widgets/pending_campaign/list_pending_campaigns.widget.dart';

class PendingCampaignPage extends StatelessWidget {
  const PendingCampaignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PendingCampaignBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<PendingCampaignBloc, PendingCampaignState>(
        listener: _onListener,
        child: const _PendingCampaignView(),
      ),
    );
  }

  void _onListener(BuildContext context, PendingCampaignState state) {}
}

class _PendingCampaignView extends StatelessWidget {
  const _PendingCampaignView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.campaign_my_voluntary_campaigns.tr(),
        ),
        backgroundColor: ColorStyles.primary1,
      ),
      body: BlocBuilder<PendingCampaignBloc, PendingCampaignState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return ListPendingCampaignsWidet(
            campaigns: state.campaigns,
          );
        },
      ),
    );
  }
}

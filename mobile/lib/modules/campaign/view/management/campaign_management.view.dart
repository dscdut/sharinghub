import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/conditional_render.util.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/bloc/management/campaign_management.bloc.dart';
import 'package:mobile/modules/campaign/widgets/management/add_campaign_fab.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/campaign_get_common_error.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/list_campaigns.widget.dart';
import 'package:mobile/modules/campaign/widgets/management/organization_management_app_bar.widget.dart';

class CampaignManagementPage extends StatelessWidget {
  const CampaignManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignManagementBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
        authBloc: context.read<AuthBloc>(),
      ),
      child: const _CampaignManagementView(),
    );
  }
}

class _CampaignManagementView extends StatelessWidget {
  const _CampaignManagementView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CampaignManagementAppBar(),
      body: BlocBuilder<CampaignManagementBloc, CampaignManagementState>(
        builder: (context, state) {
          return ConditionalRenderUtil.single(
            context,
            value: state.status,
            caseBuilders: {
              HandleStatus.loading: (_) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
              HandleStatus.error: (_) =>
                  const Center(child: CampaignGetCommonError()),
              HandleStatus.initial: (_) => const SizedBox(),
            },
            fallbackBuilder: (_) {
              if (state.campaigns.isEmpty) {
                return Center(
                  child: CampaignGetCommonError(
                    isEmpty: state.campaigns.isEmpty,
                  ),
                );
              }

              return ListCampaigns(campaigns: state.campaigns);
            },
          );
        },
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 5),
        child: AddCampaignFAB(),
      ),
    );
  }
}

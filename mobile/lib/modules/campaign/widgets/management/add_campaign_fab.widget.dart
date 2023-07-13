import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/bloc/management/campaign_management.bloc.dart';
import 'package:mobile/configs/router/app_routes.dart';

class AddCampaignFAB extends StatelessWidget {
  const AddCampaignFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignManagementBloc, CampaignManagementState>(
      builder: (context, state) {
        return Visibility(
          visible: state.status.isSuccess && state.campaigns.isNotEmpty,
          child: FloatingActionButton(
            backgroundColor: ColorStyles.primary4,
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.setCampaign,
                arguments: ArgumentWrapper3(
                  param1: null,
                  param2: context.read<CampaignManagementBloc>(),
                  param3: context.read<AuthBloc>(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

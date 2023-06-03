import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/configs/router/app_routes.dart';

class CampaignFeedbackButton extends StatelessWidget {
  const CampaignFeedbackButton({
    super.key,
    required this.campaign,
  });

  final CampaignModel campaign;

  bool isOrgCreateCampaign(AuthState authState) {
    return authState.status.isAuthenticatedOrganization &&
        authState.currentOrganizationId == campaign.organizationId;
  }

  bool hasOrgFeedback(AuthState authState) {
    return authState.status.isAuthenticatedOrganization && campaign.hasFeedback;
  }

  bool hasParticipantFeedback(AuthState authState) {
    return !authState.status.isAuthenticatedOrganization &&
        campaign.isUserGaveFeedback;
  }

  void _onFeedbackButtonPressed(BuildContext context) {
    final String route = isOrgCreateCampaign(context.read<AuthBloc>().state)
        ? AppRoutes.organizationFeedback
        : AppRoutes.participantFeedback;

    Navigator.of(context).pushNamed(
      route,
      arguments: campaign,
    );
  }

  Widget _buildFeedbackButton(BuildContext context) {
    return AppRoundedButton(
      width: double.infinity,
      backgroundColor: ColorStyles.primary1,
      onPressed: () => _onFeedbackButtonPressed(context),
      content: hasOrgFeedback(context.read<AuthBloc>().state) ||
              hasParticipantFeedback(context.read<AuthBloc>().state)
          ? LocaleKeys.button_edit_feedback.tr()
          : LocaleKeys.button_send_feedback.tr(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.read<AuthBloc>().state.status.isAuthenticatedOrganization
        ? context.read<AuthBloc>().state.currentOrganizationId ==
                campaign.organizationId
            ? _buildFeedbackButton(context)
            : const SizedBox()
        : campaign.isUserJoined
            ? _buildFeedbackButton(context)
            : const SizedBox();
  }
}

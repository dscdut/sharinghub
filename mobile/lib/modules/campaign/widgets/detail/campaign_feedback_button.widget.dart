import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignFeedbackButton extends StatelessWidget {
  const CampaignFeedbackButton({
    super.key,
    required this.campaign,
  });

  final CampaignModel campaign;

  @override
  Widget build(BuildContext context) {
    return AppRoundedButton(
      width: double.infinity,
      onPressed: () {
        context.read<AuthBloc>().state.status.isAuthenticatedOrganization
            ? Navigator.pushNamed(
                context,
                AppRoutes.organizationFeedback,
                arguments: campaign,
              )
            : Navigator.pushNamed(
                context,
                AppRoutes.individualFeedback,
                arguments: campaign,
              );
      },
      content: campaign.hasFeedback
          ? LocaleKeys.button_edit_feedback.tr()
          : LocaleKeys.button_send_feedback.tr(),
    );
  }
}

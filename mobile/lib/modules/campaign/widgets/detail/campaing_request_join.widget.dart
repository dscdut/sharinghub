import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/detail/campaign_detail.bloc.dart';
import 'package:mobile/router/app_routes.dart';

class CampaignRequestJoin extends StatelessWidget {
  const CampaignRequestJoin({
    super.key,
    this.formLink,
    this.artifactTypes,
  });

  final String? formLink;
  final String? artifactTypes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: AppRoundedButton(
              width: double.infinity,
              isDisable: formLink == null,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.campaignRegister,
                  arguments: formLink,
                );
                context.read<CampaignDetailBloc>().add(CampaignDetailJoin());
              },
              backgroundColor: ColorStyles.primary1,
              content: LocaleKeys.button_join.tr(),
            ),
          ),
          const VerticalDivider(
            width: 10,
            color: Colors.transparent,
          ),
          Expanded(
            child: AppRoundedButton(
              isDisable: artifactTypes == null,
              width: double.infinity,
              onPressed: () {
                context.read<CampaignDetailBloc>().add(CampaignDetailJoin());
              },
              backgroundColor: ColorStyles.primary1,
              // isLoading: state.status == CampaignDetailStatus.joinLoading,
              content: 'Donate',
            ),
          )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/widgets/common_error.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/configs/router/app_routes.dart';

class CampaignGetCommonError extends StatelessWidget {
  final bool isEmpty;

  const CampaignGetCommonError({super.key, this.isEmpty = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.horizontalSpace),
      child: CommonError(
        action: isEmpty
            ? () {
                Navigator.of(context).pushNamed(
                  AppRoutes.setCampaign,
                  arguments: ArgumentWrapper3(
                    param1: null,
                    param2: context.read<CampaignManagementBloc>(),
                    param3: context.read<AuthBloc>(),
                  ),
                );
              }
            : null,
        title: isEmpty
            ? LocaleKeys.campaign_empty_list.tr()
            : LocaleKeys.texts_error_occur.tr(),
        labelAction: LocaleKeys.button_create.tr(),
      ),
    );
  }
}

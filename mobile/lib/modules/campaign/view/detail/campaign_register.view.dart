import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/campaign_register/campaign_register.bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CampaignRegisterFormPage extends StatelessWidget {
  const CampaignRegisterFormPage({
    super.key,
    required this.campaign,
  });

  final CampaignModel campaign;
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CampaignRegisterBloc(
          campaignRepository: getIt.get<CampaignRepository>(),
        ),
        child: BlocListener<CampaignRegisterBloc, CampaignRegisterState>(
          listener: _onListener,
          child: _CampaignRegisterFormPage(
            campaign: campaign,
          ),
        ),
      );

  void _onListener(BuildContext context, CampaignRegisterState state) {
    if (state is CampaignRegisterError) {
      ToastUtil.showError(
        context,
      );
    }
    if (state.status == HandleStatus.success) {
      ToastUtil.showSuccess(
        context,
      );
    }
  }
}

class _CampaignRegisterFormPage extends StatelessWidget {
  const _CampaignRegisterFormPage({
    required this.campaign,
  });

  final CampaignModel campaign;

  void onTapUrl() async {
    final url = Uri.parse(campaign.registerLink!);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.campaign_volunteer.tr()),
        backgroundColor: ColorStyles.primary1,
      ),
      body: BlocBuilder<CampaignRegisterBloc, CampaignRegisterState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => onTapUrl(),
                  child: Text(
                    LocaleKeys.campaign_volunteer_register.tr(),
                    style: TextStyles.regularSubti18.copyWith(
                      decoration: TextDecoration.underline,
                      color: ColorStyles.zodiacBlue,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              AppRoundedButton(
                onPressed: () {
                  context.read<CampaignRegisterBloc>().add(
                        CampaignRegisterSubmit(
                          campaignID: campaign.id!,
                        ),
                      );
                },
                isLoading: state.status.isLoading,
                width: double.infinity,
                backgroundColor: ColorStyles.primary1,
                content: LocaleKeys.campaign_complete.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

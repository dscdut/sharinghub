import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/theme/text_styles.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/campaign/bloc/campaign_register/campaign_register.bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CampaignRegisterFormPage extends StatelessWidget {
  const CampaignRegisterFormPage({
    super.key,
    required this.formLink,
  });

  final String formLink;
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => CampaignRegisterBloc(),
        child: _CampaignRegisterFormPage(
          formLink: formLink,
        ),
      );
}

class _CampaignRegisterFormPage extends StatelessWidget {
  const _CampaignRegisterFormPage({
    required this.formLink,
  });

  final String formLink;

  void onTapUrl() async {
    final url = Uri.parse(formLink);
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
        backgroundColor: Colors.blue,
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
                  context
                      .read<CampaignRegisterBloc>()
                      .add(CampaignRegisterSuccess());
                },
                width: double.infinity,
                backgroundColor: Colors.blue,
                content: LocaleKeys.campaign_complete.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

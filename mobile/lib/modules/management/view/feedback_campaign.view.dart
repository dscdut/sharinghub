import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/file.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/management/management.dart';
import 'package:mobile/modules/management/widgets/feedback_campaign/feedback_campaign_form.widget.dart';

class FeedbackCampaignPage extends StatelessWidget {
  final CampaignModel campaign;

  const FeedbackCampaignPage({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedbackCampaignBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: _FeedbackCampaignView(campaign: campaign),
    );
  }
}

class _FeedbackCampaignView extends StatefulWidget {
  final CampaignModel campaign;

  const _FeedbackCampaignView({
    required this.campaign,
  });

  @override
  State<_FeedbackCampaignView> createState() => _FeedbackCampaignViewState();
}

class _FeedbackCampaignViewState extends State<_FeedbackCampaignView> {
  FeedbackToCampaignDTO feedbackToCampaignDTO = FeedbackToCampaignDTO();

  final _formKey = GlobalKey<FormState>();
  final _trafficEditingController = TextEditingController();
  final _weatherEditingController = TextEditingController();
  final _sanitizationEditingController = TextEditingController();
  final _residenceEditingController = TextEditingController();
  final _authorityCooperationEditingController = TextEditingController();
  final _othersEditingController = TextEditingController();

  Future<void> _setFeedbackImages(List<File> files) async {
    final List<dynamic> images = [];
    for (File file in files) {
      images.add(await FileUtil.toMultipartFile(file));
    }
    feedbackToCampaignDTO.images = images;
  }

  void _collectDataForFeedbackCampaign() {
    feedbackToCampaignDTO = feedbackToCampaignDTO.copyWith(
      locationRate: feedbackToCampaignDTO.locationRate,
      traffic: _trafficEditingController.text,
      weather: _weatherEditingController.text,
      sanitization: _sanitizationEditingController.text,
      residence: _residenceEditingController.text,
      authorityCooperation: _authorityCooperationEditingController.text,
      others: _othersEditingController.text,
    );
  }

  void _submitFeedbackCampaign(BuildContext context) {
    _collectDataForFeedbackCampaign();
    log(feedbackToCampaignDTO.locationRate.toString());

    context.read<FeedbackCampaignBloc>().add(
          FeedbackCampaignFormValidate(
            organizationFeedback: feedbackToCampaignDTO,
          ),
        );

    if (_formKey.currentState!.validate() &&
        context.read<FeedbackCampaignBloc>().state.isValid) {
      context.read<FeedbackCampaignBloc>().add(
            FeedbackCampaignSubmit(
              organizationFeedback: feedbackToCampaignDTO,
            ),
          );
    }
  }

  void _onLocationRateChanged(int rating) {
    feedbackToCampaignDTO.locationRate = rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.campaign.name,
        isCenterTitle: false,
        backgroundColor: Colors.white,
        titleColor: ColorStyles.zodiacBlue,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            FeedbackCampaignForm(
              formKey: _formKey,
              locationRate: feedbackToCampaignDTO.locationRate,
              trafficEditingController: _trafficEditingController,
              weatherEditingController: _weatherEditingController,
              sanitizationEditingController: _sanitizationEditingController,
              residenceEditingController: _residenceEditingController,
              authorityCooperationEditingController:
                  _authorityCooperationEditingController,
              othersEditingController: _othersEditingController,
              setFeedbackImages: _setFeedbackImages,
              onLocationRateChanged: _onLocationRateChanged,
            ),
            const SizedBox(
              height: 30,
            ),
            AppRoundedButton(
              onPressed: () => _submitFeedbackCampaign(context),
              width: double.infinity,
              content: LocaleKeys.button_finish.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

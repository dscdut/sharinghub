import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/file.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/organization/management.dart';
import 'package:mobile/modules/organization/widgets/feedback_campaign/feedback_campaign_form.widget.dart';

class FeedbackCampaignPage extends StatelessWidget {
  final CampaignModel campaign;

  const FeedbackCampaignPage({
    super.key,
    required this.campaign,
  });

  void _listenFeedbackCampaignStateChanged(
    BuildContext context,
    FeedbackCampaignState state,
  ) {
    if (state.status == HandleStatus.error) {
      DialogUtil.hideLoading(context);
      ToastUtil.showError(context);
    } else if (state.status == HandleStatus.success) {
      DialogUtil.hideLoading(context);
      DialogUtil.showCustomDialog(
        context,
        title: LocaleKeys.texts_success.tr(),
        content: LocaleKeys.feedback_success.tr(),
        isConfirmDialog: true,
        confirmAction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        cancelAction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        confirmButtonText: LocaleKeys.button_confirm.tr(),
        barrierDismissible: false,
      );
    } else if (state.status == HandleStatus.loading) {
      DialogUtil.showLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedbackCampaignBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<FeedbackCampaignBloc, FeedbackCampaignState>(
        listener: _listenFeedbackCampaignStateChanged,
        child: _FeedbackCampaignView(campaign: campaign),
      ),
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

  @override
  void initState() {
    super.initState();
    context.read<FeedbackCampaignBloc>().add(FeedbackCampaignInit());
    _setFeedbackCampaignDTO();
  }

  final _formKey = GlobalKey<FormState>();
  int _locationRating = 0;
  final _trafficEditingController = TextEditingController();
  final _weatherEditingController = TextEditingController();
  final _sanitizationEditingController = TextEditingController();
  final _residenceEditingController = TextEditingController();
  final _authorityCooperationEditingController = TextEditingController();
  final _othersEditingController = TextEditingController();
  List<dynamic> _feedbackImages = [];

  void _setFeedbackCampaignDTO() {
    if (widget.campaign.hasFeedback) {
      _setFeedbackCampaignInfo();
    }
  }

  void _setFeedbackCampaignInfo() {
    _locationRating = widget.campaign.feedback!.locationRate;
    _trafficEditingController.text = widget.campaign.feedback!.traffic ?? '';
    _weatherEditingController.text = widget.campaign.feedback!.weather ?? '';
    _sanitizationEditingController.text =
        widget.campaign.feedback!.sanitization ?? '';
    _residenceEditingController.text =
        widget.campaign.feedback!.residence ?? '';
    _authorityCooperationEditingController.text =
        widget.campaign.feedback!.authorityCooperation ?? '';
    _othersEditingController.text = widget.campaign.feedback!.others ?? '';
    _feedbackImages = widget.campaign.feedback!.images ?? [];
  }

  Future<void> _setFeedbackImages(List<File> files) async {
    final List<dynamic> images = [];
    for (File file in files) {
      images.add(await FileUtil.toMultipartFile(file));
    }
    _feedbackImages = images;
  }

  void _collectDataForFeedbackCampaign() {
    feedbackToCampaignDTO = feedbackToCampaignDTO.copyWith(
      locationRate: _locationRating,
      traffic: _trafficEditingController.text,
      weather: _weatherEditingController.text,
      sanitization: _sanitizationEditingController.text,
      residence: _residenceEditingController.text,
      authorityCooperation: _authorityCooperationEditingController.text,
      others: _othersEditingController.text,
      images: _feedbackImages,
    );
  }

  void _submitFeedbackCampaign(BuildContext context) {
    _collectDataForFeedbackCampaign();

    context.read<FeedbackCampaignBloc>().add(
          FeedbackCampaignFormValidate(
            organizationFeedback: feedbackToCampaignDTO,
          ),
        );

    if (_formKey.currentState!.validate()) {
      context.read<FeedbackCampaignBloc>().add(
            FeedbackCampaignSubmit(
              organizationFeedback: feedbackToCampaignDTO,
            ),
          );
    }
  }

  void _onLocationRateChanged(int rating) {
    _locationRating = rating;
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
              locationRate: _locationRating,
              trafficEditingController: _trafficEditingController,
              weatherEditingController: _weatherEditingController,
              sanitizationEditingController: _sanitizationEditingController,
              residenceEditingController: _residenceEditingController,
              authorityCooperationEditingController:
                  _authorityCooperationEditingController,
              othersEditingController: _othersEditingController,
              setFeedbackImages: _setFeedbackImages,
              onLocationRateChanged: _onLocationRateChanged,
              imagePaths: _feedbackImages,
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

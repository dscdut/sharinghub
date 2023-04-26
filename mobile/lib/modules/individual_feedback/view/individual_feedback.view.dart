import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/file.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/individual_feedback/individual_feedback.dart';

class IndividualFeedbackPage extends StatelessWidget {
  final CampaignModel campaign;

  const IndividualFeedbackPage({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IndividualFeedbackBloc(),
      child: _IndividualFeedbackView(campaign: campaign),
    );
  }
}

class _IndividualFeedbackView extends StatefulWidget {
  final CampaignModel campaign;

  const _IndividualFeedbackView({
    required this.campaign,
  });

  @override
  State<_IndividualFeedbackView> createState() =>
      _IndividualFeedbackViewState();
}

class _IndividualFeedbackViewState extends State<_IndividualFeedbackView> {
  final _formKey = GlobalKey<FormState>();
  int _campRating = 0;
  int _orgRating = 0;
  final _campaignEditingController = TextEditingController();
  final _orgEditingController = TextEditingController();
  List<dynamic> _feedbackImages = [];

  Future<void> _setFeedbackImages(List<File> files) async {
    final List<dynamic> images = [];
    for (File file in files) {
      images.add(await FileUtil.toMultipartFile(file));
    }
    _feedbackImages = images;
  }

  void _onCampRateChanged(int rating) {
    _campRating = rating;
  }

  void _onOrgRateChanged(int rating) {
    _orgRating = rating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleColor: ColorStyles.zodiacBlue,
        title: widget.campaign.name,
        isCenterTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.horizontalSpace),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            IndividualFeedbackForm(
              formKey: _formKey,
              campRate: _campRating,
              orgRate: _orgRating,
              campEditingController: _campaignEditingController,
              orgEditingController: _orgEditingController,
              onCampRateChanged: _onCampRateChanged,
              onOrgRateChanged: _onOrgRateChanged,
              imagePaths: _feedbackImages,
              setFeedbackImages: _setFeedbackImages,
            ),
            const SizedBox(
              height: 30,
            ),
            AppRoundedButton(
              onPressed: () => {},
              width: double.infinity,
              content: LocaleKeys.button_finish.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

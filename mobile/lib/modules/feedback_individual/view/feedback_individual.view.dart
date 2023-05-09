import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/theme/app_size.dart';
import 'package:mobile/common/theme/color_styles.dart';
import 'package:mobile/common/utils/dialog.util.dart';
import 'package:mobile/common/utils/toast.util.dart';
import 'package:mobile/common/widgets/app_rounded_button.widget.dart';
import 'package:mobile/common/widgets/custom_app_bar.widget.dart';
import 'package:mobile/data/dtos/feedback_individual.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/feedback_individual/feedback_individual.dart';

class FeedbackIndividualPage extends StatelessWidget {
  final CampaignModel campaign;

  const FeedbackIndividualPage({
    super.key,
    required this.campaign,
  });

  void _listenFeedbackIndividualStateChanged(
    BuildContext context,
    FeedbackIndividualState state,
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
      create: (_) => FeedbackIndividualBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<FeedbackIndividualBloc, FeedbackIndividualState>(
        listener: _listenFeedbackIndividualStateChanged,
        child: _FeedbackIndividualView(campaign: campaign),
      ),
    );
  }
}

class _FeedbackIndividualView extends StatefulWidget {
  final CampaignModel campaign;

  const _FeedbackIndividualView({
    required this.campaign,
  });

  @override
  State<_FeedbackIndividualView> createState() =>
      _FeedbackIndividualViewState();
}

class _FeedbackIndividualViewState extends State<_FeedbackIndividualView> {
  FeedbackIndividualDTO feedbackIndividualDTO = FeedbackIndividualDTO();

  @override
  void initState() {
    super.initState();
    context.read<FeedbackIndividualBloc>().add(FeedbackIndividualInit());
    _setFeedbackIndividualDTO();
  }

  final _formKey = GlobalKey<FormState>();
  int _campRating = 0;
  int _orgRating = 0;
  final _campaignEditingController = TextEditingController();
  final _orgEditingController = TextEditingController();

  void _setFeedbackIndividualDTO() {
    if (widget.campaign.hasFeedback) {
      _setFeedbackIndividualInfo();
    }
  }

  void _setFeedbackIndividualInfo() {
    // _campRating = widget.campaign.feedback!.campaignRating!;
    // _orgRating = widget.campaign.feedback!.organizationRating!;
    // _campaignEditingController.text =
    //     widget.campaign. ?? '';
    // _orgEditingController.text = widget.campaign. ?? '';
  }

  void _collectDataForFeedbackCampaign() {
    feedbackIndividualDTO = feedbackIndividualDTO.copyWith(
      campaignRate: _campRating,
      campaignReview: _campaignEditingController.text,
      organizationRate: _orgRating,
      organizationReview: _orgEditingController.text,
      campaignId: widget.campaign.id,
    );
  }

  void _submitFeedbackIndividual(BuildContext context) {
    _collectDataForFeedbackCampaign();

    context.read<FeedbackIndividualBloc>().add(
          FeedbackIndividualFormValidate(
            individualFeedback: feedbackIndividualDTO,
          ),
        );

    if (_formKey.currentState!.validate()) {
      context.read<FeedbackIndividualBloc>().add(
            FeedbackIndividualSubmit(
              individualFeedback: feedbackIndividualDTO,
            ),
          );
    }
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
            FeedbackIndividualForm(
              formKey: _formKey,
              campRate: _campRating,
              orgRate: _orgRating,
              campEditingController: _campaignEditingController,
              orgEditingController: _orgEditingController,
              onCampRateChanged: _onCampRateChanged,
              onOrgRateChanged: _onOrgRateChanged,
            ),
            const SizedBox(
              height: 30,
            ),
            AppRoundedButton(
              onPressed: () => _submitFeedbackIndividual(context),
              width: double.infinity,
              content: LocaleKeys.button_finish.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

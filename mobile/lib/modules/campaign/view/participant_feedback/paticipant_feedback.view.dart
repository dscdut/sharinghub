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
import 'package:mobile/data/dtos/paticipant_feedback.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:mobile/modules/auth/auth.dart';
import 'package:mobile/modules/campaign/campaign.dart';
import 'package:mobile/modules/campaign/widgets/participant_feedback/paticipant_feedback_form.widget.dart';

class ParticipantFeedbackPage extends StatelessWidget {
  final CampaignModel campaign;

  const ParticipantFeedbackPage({
    super.key,
    required this.campaign,
  });

  void _listenParticipantFeedbackStateChanged(
    BuildContext context,
    ParticipantFeedbackState state,
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
      create: (_) => ParticipantFeedbackBloc(
        campaignRepository: getIt.get<CampaignRepository>(),
      ),
      child: BlocListener<ParticipantFeedbackBloc, ParticipantFeedbackState>(
        listener: _listenParticipantFeedbackStateChanged,
        child: _ParticipantFeedbackView(campaign: campaign),
      ),
    );
  }
}

class _ParticipantFeedbackView extends StatefulWidget {
  final CampaignModel campaign;

  const _ParticipantFeedbackView({
    required this.campaign,
  });

  @override
  State<_ParticipantFeedbackView> createState() =>
      _ParticipantFeedbackViewState();
}

class _ParticipantFeedbackViewState extends State<_ParticipantFeedbackView> {
  ParticipantFeedbackDTO participantFeedbackDTO = ParticipantFeedbackDTO();

  @override
  void initState() {
    super.initState();
    context.read<ParticipantFeedbackBloc>().add(ParticipantFeedbackInit());
    _setParticipantFeedbackDTO();
  }

  final _formKey = GlobalKey<FormState>();
  int _campRating = 0;
  int _orgRating = 0;
  final _campaignEditingController = TextEditingController();
  final _orgEditingController = TextEditingController();

  void _setParticipantFeedbackDTO() {
    if (widget.campaign.isUserGaveFeedback) {
      _setParticipantFeedbackInfo();
    }
  }

  void _setParticipantFeedbackInfo() {
    ParticipantFeedbackDTO user = widget.campaign.userFeedbacks
        .where((e) => e.user!.id == context.read<AuthBloc>().state.user!.id)
        .first;
    _campRating = user.campaignRate;
    _orgRating = user.organizationRate;
    _campaignEditingController.text = user.campaignFeedback ?? '';
    _orgEditingController.text = user.organizationFeedback ?? '';
  }

  void _collectDataForFeedbackCampaign() {
    participantFeedbackDTO = participantFeedbackDTO.copyWith(
      campaignRate: _campRating,
      campaignFeedback: _campaignEditingController.text,
      organizationRate: _orgRating,
      organizationFeedback: _orgEditingController.text,
      campaignId: widget.campaign.id,
    );
  }

  void _submitParticipantFeedback(BuildContext context) {
    _collectDataForFeedbackCampaign();

    context.read<ParticipantFeedbackBloc>().add(
          ParticipantFeedbackFormValidate(
            participantFeedbackDTO: participantFeedbackDTO,
          ),
        );

    if (_formKey.currentState!.validate()) {
      context.read<ParticipantFeedbackBloc>().add(
            ParticipantFeedbackSubmit(
              participantFeedback: participantFeedbackDTO,
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
            ParticipantFeedbackForm(
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
              onPressed: () => _submitParticipantFeedback(context),
              width: double.infinity,
              content: LocaleKeys.button_finish.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

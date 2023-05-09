import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'feedback_campaign.event.dart';
part 'feedback_campaign.state.dart';

class FeedbackCampaignBloc
    extends Bloc<FeedbackCampaignEvent, FeedbackCampaignState> {
  final CampaignRepository _campaignRepository;

  FeedbackCampaignBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const FeedbackCampaignState()) {
    on<FeedbackCampaignInit>(_onInitFeedbackCampaign);
    on<FeedbackCampaignFormValidate>(_onValidateFeedbackCampaign);
    on<FeedbackCampaignSubmit>(_onSubmitFeedbackCampaign);
  }

  Future<void> _onInitFeedbackCampaign(
    FeedbackCampaignInit event,
    Emitter<FeedbackCampaignState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        rateError: const Wrapped.value(null),
        imageError: const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onValidateFeedbackCampaign(
    FeedbackCampaignFormValidate event,
    Emitter<FeedbackCampaignState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        rateError: event.organizationFeedback.locationRate == 0.0
            ? Wrapped.value(LocaleKeys.validator_location_rate.tr())
            : const Wrapped.value(null),
        imageError: event.organizationFeedback.images == null ||
                event.organizationFeedback.images!.isEmpty
            ? Wrapped.value(LocaleKeys.feedback_images_uploaded.tr())
            : const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onSubmitFeedbackCampaign(
    FeedbackCampaignSubmit event,
    Emitter<FeedbackCampaignState> emitter,
  ) async {
    if (state.imageError == null && state.rateError == null) {
      emitter(
        state.copyWith(
          status: HandleStatus.loading,
        ),
      );
      
      try {
        await _campaignRepository
            .feedbackToCampaign(event.organizationFeedback);

        emitter(
          state.copyWith(
            status: HandleStatus.success,
            imageError: const Wrapped.value(null),
            rateError: const Wrapped.value(null),
          ),
        );
      } catch (_) {
        emitter(state.copyWith(status: HandleStatus.error));
      }
    }
  }
}

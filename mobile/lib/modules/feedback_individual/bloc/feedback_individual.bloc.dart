import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/feedback_individual.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'feedback_individual.event.dart';
part 'feedback_individual.state.dart';

class FeedbackIndividualBloc
    extends Bloc<FeedbackIndividualEvent, FeedbackIndividualState> {
  final CampaignRepository _campaignRepository;

  FeedbackIndividualBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const FeedbackIndividualState()) {
    on<FeedbackIndividualInit>(_onInitFeedbackIndividual);
    on<FeedbackIndividualFormValidate>(_onValidateFeedbackIndividual);
    on<FeedbackIndividualSubmit>(_onSubmitFeedbackIndividual);
  }

  Future<void> _onInitFeedbackIndividual(
    FeedbackIndividualInit event,
    Emitter<FeedbackIndividualState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        campaignRateError: const Wrapped.value(null),
        organizationRateError: const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onValidateFeedbackIndividual(
    FeedbackIndividualFormValidate event,
    Emitter<FeedbackIndividualState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        campaignRateError: event.individualFeedback.campaignRate == 0.0
            ? Wrapped.value(LocaleKeys.validator_campaign_rate.tr())
            : const Wrapped.value(null),
        organizationRateError: event.individualFeedback.organizationRate == 0.0
            ? Wrapped.value(LocaleKeys.validator_organization_rate.tr())
            : const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onSubmitFeedbackIndividual(
    FeedbackIndividualSubmit event,
    Emitter<FeedbackIndividualState> emitter,
  ) async {
    if (state.campaignRateError == null &&
        state.organizationRateError == null) {
      emitter(
        state.copyWith(
          status: HandleStatus.loading,
        ),
      );

      try {
        await _campaignRepository.feedbackIndividual(event.individualFeedback);

        emitter(
          state.copyWith(
            status: HandleStatus.success,
            campaignRateError: const Wrapped.value(null),
            organizationRateError: const Wrapped.value(null),
          ),
        );
      } catch (_) {
        emitter(state.copyWith(status: HandleStatus.error));
      }
    }
  }
}

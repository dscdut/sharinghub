import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/paticipant_feedback.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'paticipant_feedback.event.dart';
part 'paticipant_feedback.state.dart';

class ParticipantFeedbackBloc
    extends Bloc<ParticipantFeedbackEvent, ParticipantFeedbackState> {
  final CampaignRepository _campaignRepository;

  ParticipantFeedbackBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const ParticipantFeedbackState()) {
    on<ParticipantFeedbackInit>(_onInitParticipantFeedback);
    on<ParticipantFeedbackFormValidate>(_onValidateParticipantFeedback);
    on<ParticipantFeedbackSubmit>(_onSubmitParticipantFeedback);
  }

  Future<void> _onInitParticipantFeedback(
    ParticipantFeedbackInit event,
    Emitter<ParticipantFeedbackState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        campaignRateError: const Wrapped.value(null),
        organizationRateError: const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onValidateParticipantFeedback(
    ParticipantFeedbackFormValidate event,
    Emitter<ParticipantFeedbackState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        campaignRateError: event.participantFeedbackDTO.campaignRate == 0.0
            ? Wrapped.value(LocaleKeys.validator_campaign_rate.tr())
            : const Wrapped.value(null),
        organizationRateError: event.participantFeedbackDTO.organizationRate == 0.0
            ? Wrapped.value(LocaleKeys.validator_organization_rate.tr())
            : const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onSubmitParticipantFeedback(
    ParticipantFeedbackSubmit event,
    Emitter<ParticipantFeedbackState> emitter,
  ) async {
    if (state.campaignRateError == null &&
        state.organizationRateError == null) {
      emitter(
        state.copyWith(
          status: HandleStatus.loading,
        ),
      );

      try {
        if (!event.isUpdate) {
          await _campaignRepository
              .participantFeedback(event.participantFeedback);
        } else {
          await _campaignRepository
              .updateParticipantFeedback(event.participantFeedback);
        }
        await _campaignRepository.participantFeedback(event.participantFeedback);

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

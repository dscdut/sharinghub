import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/organization_feedback.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'organization_feedback.event.dart';
part 'organization_feedback.state.dart';

class OrganizationFeedbackBloc
    extends Bloc<OrganizationFeedbackEvent, OrganizationFeedbackState> {
  final CampaignRepository _campaignRepository;

  OrganizationFeedbackBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const OrganizationFeedbackState()) {
    on<OrganizationFeedbackInit>(_onInitOrganizationFeedback);
    on<OrganizationFeedbackFormValidate>(_onValidateOrganizationFeedback);
    on<OrganizationFeedbackSubmit>(_onSubmitOrganizationFeedback);
  }

  Future<void> _onInitOrganizationFeedback(
    OrganizationFeedbackInit event,
    Emitter<OrganizationFeedbackState> emitter,
  ) async {
    emitter(
      state.copyWith(
        status: HandleStatus.initial,
        rateError: const Wrapped.value(null),
        imageError: const Wrapped.value(null),
      ),
    );
  }

  Future<void> _onValidateOrganizationFeedback(
    OrganizationFeedbackFormValidate event,
    Emitter<OrganizationFeedbackState> emitter,
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

  Future<void> _onSubmitOrganizationFeedback(
    OrganizationFeedbackSubmit event,
    Emitter<OrganizationFeedbackState> emitter,
  ) async {
    if (state.imageError == null && state.rateError == null) {
      emitter(
        state.copyWith(
          status: HandleStatus.loading,
        ),
      );

      try {
        if (!event.isUpdate) {
          await _campaignRepository
              .organizationFeedback(event.organizationFeedback);
        } else {
          await _campaignRepository
              .updateOrganizationFeedback(event.organizationFeedback);
        }

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

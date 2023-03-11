import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'set_campaign.event.dart';
part 'set_campaign.state.dart';

class SetCampaignBloc extends Bloc<SetCampaignEvent, SetCampaignState> {
  final CampaignRepository _campaignRepository;

  SetCampaignBloc({required CampaignRepository campaignRepository})
      : _campaignRepository = campaignRepository,
        super(const SetCampaignState()) {
    on<SetCampaignSubmit>(_onSubmitCampaign);
    on<SetCampaignFormValidate>(_onValidateCampaignForm);
  }

  Future<void> _onSubmitCampaign(
    SetCampaignSubmit event,
    Emitter<SetCampaignState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HandleStatus.loading,
        imageError: const Wrapped.value(null),
        dateRangeError: const Wrapped.value(null),
      ),
    );

    try {
      await _campaignRepository.setCampaign(event.setCampaign);

      emit(state.copyWith(status: HandleStatus.success));
    } catch (_) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }

  void _onValidateCampaignForm(
    SetCampaignFormValidate event,
    Emitter<SetCampaignState> emit,
  ) {
    emit(
      state.copyWith(
        imageError: event.setCampaign.image == null
            ? Wrapped.value(LocaleKeys.validator_campaign_avatar_uploaded.tr())
            : const Wrapped.value(null),
        dateRangeError: (event.setCampaign.startDate == null ||
                event.setCampaign.endDate == null)
            ? Wrapped.value(LocaleKeys.validator_field_required.tr())
            : const Wrapped.value(null),
      ),
    );
  }
}

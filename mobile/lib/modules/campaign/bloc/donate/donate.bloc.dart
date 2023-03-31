import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/common/utils/wrapped_value.dart';
import 'package:mobile/data/dtos/set_donate.dto.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'donate.event.dart';
part 'donate.state.dart';

class DonateBloc extends Bloc<DonateEvent, DonateState> {
  final CampaignRepository _campaignRepository;

  DonateBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const DonateState()) {
    on<DonateSubmit>(_onSubmitDonate);
    on<DonateFormValidate>(_onValidateDonateForm);
  }

  Future<void> _onSubmitDonate(
    DonateSubmit event,
    Emitter<DonateState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HandleStatus.loading,
        imageError: const Wrapped.value(null),
      ),
    );
    try {
      await _campaignRepository.donateToCampaign(event.setDonate);

      emit(state.copyWith(status: HandleStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }

  void _onValidateDonateForm(
    DonateFormValidate event,
    Emitter<DonateState> emit,
  ) {
    emit(
      state.copyWith(
        imageError: event.setDonate.image == null
            ? Wrapped.value(LocaleKeys.validator_campaign_avatar_uploaded.tr())
            : const Wrapped.value(null),
      ),
    );
  }
}

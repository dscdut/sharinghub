import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';

part 'campaign_register.event.dart';
part 'campaign_register.state.dart';

class CampaignRegisterBloc
    extends Bloc<CampaignRegisterEvent, CampaignRegisterState> {
  final CampaignRepository _campaignRepository;
  CampaignRegisterBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(
          const CampaignRegisterState(
            status: HandleStatus.initial,
          ),
        ) {
    on<CampaignRegisterSubmit>(_onRegisterSubmit);
  }

  Future<void> _onRegisterSubmit(
    CampaignRegisterSubmit event,
    Emitter<CampaignRegisterState> emit,
  ) async {
    try {
      emit(const CampaignRegisterState.loading());
      await _campaignRepository.joinCampaign(event.campaignID);
      emit(const CampaignRegisterState.success());
    } catch (e) {
      addError(e);
      emit(CampaignRegisterError(message: e.toString()));
    }
  }
}

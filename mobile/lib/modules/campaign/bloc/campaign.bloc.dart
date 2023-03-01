import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';

part 'campaign.event.dart';
part 'campaign.state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository _projectRepository;

  CampaignBloc({required CampaignRepository projectRepository})
      : _projectRepository = projectRepository,
        super(const CampaignState()) {
    on<CampaignSubmit>(_onCampaignSubmit);
  }

  Future<void> _onCampaignSubmit(
    CampaignSubmit event,
    Emitter<CampaignState> emitter,
  ) async {
    emitter(state.copyWith(status: HandleStatus.loading));

    try {
      await _projectRepository.setCampaign(event.project);

      emitter(state.copyWith(status: HandleStatus.success));
    } catch (_) {
      emitter(state.copyWith(status: HandleStatus.error));
    }
  }
}

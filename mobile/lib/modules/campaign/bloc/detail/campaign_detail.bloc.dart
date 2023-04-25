import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';

part 'campaign_detail.event.dart';
part 'campaign_detail.state.dart';

class CampaignDetailBloc
    extends Bloc<CampaignDetailEvent, CampaignDetailState> {
  final CampaignRepository _campaignRepository;

  CampaignDetailBloc({required CampaignRepository campaignRepository})
      : _campaignRepository = campaignRepository,
        super(const CampaignDetailState()) {
    on<CampaignDetailGet>(_onGetCampaignDetail);
  }

  Future<void> _onGetCampaignDetail(
    CampaignDetailGet event,
    Emitter<CampaignDetailState> emit,
  ) async {
    emit(state.copyWith(status: CampaignDetailStatus.getLoading));

    try {
      final CampaignModel campaign =
          await _campaignRepository.getCampaignDetail(event.campaignId);

      emit(
        state.copyWith(
          status: CampaignDetailStatus.getSuccess,
          campaign: campaign,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: CampaignDetailStatus.getFailed));
    }
  }
}

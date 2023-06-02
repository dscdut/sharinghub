import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';

part 'pending_campaign_event.dart';
part 'pending_campaign_state.dart';

class PendingCampaignBloc
    extends Bloc<PendingCampaignEvent, PendingCampaignState> {
  PendingCampaignBloc({
    required CampaignRepository campaignRepository,
  })  : _campaignRepository = campaignRepository,
        super(const PendingCampaignState.initial()) {
    on<PendingCampaignStarted>(_getCampaigns);

    add(const PendingCampaignStarted());
  }

  final CampaignRepository _campaignRepository;

  Future<void> _getCampaigns(
    PendingCampaignStarted event,
    Emitter<PendingCampaignState> emiter,
  ) async {
    try {
      emiter(
        state.copyWith(
          status: HandleStatus.loading,
        ),
      );
      // get campaign
      var result = await _campaignRepository.getMyVolunteer();
      emiter(PendingCampaignState.success(campaigns: result));
    } catch (e) {
      emiter(
        PendingCampaignState.failure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

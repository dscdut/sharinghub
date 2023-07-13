import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/modules/auth/bloc/auth/auth.bloc.dart';

part 'pending_campaign_event.dart';
part 'pending_campaign_state.dart';

class PendingCampaignBloc
    extends Bloc<PendingCampaignEvent, PendingCampaignState> {
  PendingCampaignBloc({
    required CampaignRepository campaignRepository,
    required AuthBloc authBloc,
  })  : _campaignRepository = campaignRepository,
        _authBloc = authBloc,
        super(const PendingCampaignState.initial()) {
    on<PendingCampaignStarted>(_getCampaigns);

    add(const PendingCampaignStarted());
  }

  final CampaignRepository _campaignRepository;
  final AuthBloc _authBloc;

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
      List<CampaignModel> campaigns = [];
      if (_authBloc.state.user!.currentOrganization != null) {
        campaigns = await _campaignRepository.getOrgCampaigns(
          _authBloc.state.user!.currentOrganization!.id,
        );
      } else {
        campaigns = await _campaignRepository.getMyVolunteer();
      }
      emiter(
        PendingCampaignState.success(
          campaigns: campaigns,
        ),
      );
      emiter(PendingCampaignState.success(campaigns: campaigns));
    } catch (e) {
      emiter(
        PendingCampaignState.failure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

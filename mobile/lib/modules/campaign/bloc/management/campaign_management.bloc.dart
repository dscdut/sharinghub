import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/modules/auth/auth.dart';

part 'campaign_management.event.dart';
part 'campaign_management.state.dart';

class CampaignManagementBloc
    extends Bloc<CampaignManagementEvent, CampaignManagementState> {
  final CampaignRepository _campaignRepository;
  final AuthBloc _authBloc;

  CampaignManagementBloc({
    required CampaignRepository campaignRepository,
    required AuthBloc authBloc,
  })  : _campaignRepository = campaignRepository,
        _authBloc = authBloc,
        super(const CampaignManagementState()) {
    on<CampaignManagementGet>(_onGetCampaigns);
    add(const CampaignManagementGet());
  }

  Future<void> _onGetCampaigns(
    CampaignManagementGet event,
    Emitter<CampaignManagementState> emit,
  ) async {
    emit(state.copyWith(status: HandleStatus.loading));

    try {
      final result = await _campaignRepository.getCampaignsByOrganizationId(
        _authBloc.state.currentOrganizationId,
      );

      emit(state.copyWith(status: HandleStatus.success, campaigns: result));
    } catch (err) {
      emit(state.copyWith(status: HandleStatus.error));
    }
  }
}

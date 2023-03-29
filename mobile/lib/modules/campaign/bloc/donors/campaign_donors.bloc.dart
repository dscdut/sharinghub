import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';

part 'campaign_donors.event.dart';
part 'campaign_donors.state.dart';

class CampaignDonorsBloc
    extends Bloc<CampaignDonorsEvent, CampaignDonorsState> {
  CampaignDonorsBloc() : super(const CampaignDonorsState.initial()) {
    on<CampaignDonorsStarted>(_start);
    add(const CampaignDonorsStarted());
  }

  Future<void> _start(
    CampaignDonorsStarted event,
    Emitter<CampaignDonorsState> emit,
  ) async {
    emit(state.copyWith(status: HandleStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: HandleStatus.success));
  }
}

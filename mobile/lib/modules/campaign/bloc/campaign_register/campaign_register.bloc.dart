import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'campaign_register.event.dart';
part 'campaign_register.state.dart';

class CampaignRegisterBloc
    extends Bloc<CampaignRegisterEvent, CampaignRegisterState> {
  CampaignRegisterBloc() : super(const CampaignRegisterState()) {
    on<CampaignRegisterSuccess>(_onRegisterSuccess);
  }

  Future<void> _onRegisterSuccess(
    CampaignRegisterSuccess event,
    Emitter<CampaignRegisterState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    emit(const CampaignRegisterState.success());
  }
}

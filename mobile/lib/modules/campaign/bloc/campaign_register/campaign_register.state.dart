part of 'campaign_register.bloc.dart';

class CampaignRegisterState extends Equatable {
  final bool isRegisted;

  const CampaignRegisterState({
    this.isRegisted = false,
  });

  const CampaignRegisterState.success({
    this.isRegisted = true,
  });

  @override
  List<Object?> get props => [
        isRegisted,
      ];
}

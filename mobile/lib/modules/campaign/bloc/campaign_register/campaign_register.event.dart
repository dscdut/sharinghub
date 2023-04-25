part of 'campaign_register.bloc.dart';

class CampaignRegisterEvent extends Equatable {
  const CampaignRegisterEvent();

  @override
  List<Object?> get props => [];
}

class CampaignRegisterSubmit extends CampaignRegisterEvent {
  final int campaignID;

  const CampaignRegisterSubmit({
    required this.campaignID,
  });

  @override
  List<Object?> get props => [
        campaignID,
      ];
}

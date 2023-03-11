part of 'set_campaign.bloc.dart';

abstract class SetCampaignEvent extends Equatable {
  const SetCampaignEvent();

  @override
  List<Object> get props => [];
}

class SetCampaignSubmit extends SetCampaignEvent {
  final SetCampaignDTO setCampaign;

  const SetCampaignSubmit({required this.setCampaign});

  @override
  List<Object> get props => [setCampaign];
}

class SetCampaignFormValidate extends SetCampaignEvent {
  final SetCampaignDTO setCampaign;

  const SetCampaignFormValidate({required this.setCampaign});

  @override
  List<Object> get props => [setCampaign];
}

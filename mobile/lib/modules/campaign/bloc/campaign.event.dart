part of 'campaign.bloc.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class CampaignSubmit extends CampaignEvent {
  final CampaignModel campaign;

  const CampaignSubmit({required this.campaign});

  @override
  List<Object> get props => [campaign];
}

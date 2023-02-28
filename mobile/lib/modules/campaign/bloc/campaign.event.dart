part of 'campaign.bloc.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object> get props => [];
}

class CampaignSubmit extends CampaignEvent {
  final CampaignModel project;

  const CampaignSubmit({required this.project});

  @override
  List<Object> get props => [project];
}

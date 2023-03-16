part of 'campaign_detail.bloc.dart';

abstract class CampaignDetailEvent extends Equatable {
  const CampaignDetailEvent();

  @override
  List<Object> get props => [];
}

class CampaignDetailGet extends CampaignDetailEvent {
  final int campaignId;

  const CampaignDetailGet(this.campaignId);

  @override
  List<Object> get props => [campaignId];
}

class CampaignDetailJoin extends CampaignDetailEvent {}

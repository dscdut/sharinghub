part of 'pending_campaign_bloc.dart';

abstract class PendingCampaignEvent extends Equatable {
  const PendingCampaignEvent();

  @override
  List<Object> get props => [];
}

class PendingCampaignStarted extends PendingCampaignEvent {
  const PendingCampaignStarted();
}

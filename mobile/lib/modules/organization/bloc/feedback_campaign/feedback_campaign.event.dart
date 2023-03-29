part of 'feedback_campaign.bloc.dart';

abstract class FeedbackCampaignEvent extends Equatable {
  const FeedbackCampaignEvent();

  @override
  List<Object> get props => [];
}

class FeedbackCampaignInit extends FeedbackCampaignEvent {}

class FeedbackCampaignFormValidate extends FeedbackCampaignEvent {
  final FeedbackToCampaignDTO organizationFeedback;

  const FeedbackCampaignFormValidate({
    required this.organizationFeedback,
  });

  @override
  List<Object> get props => [organizationFeedback];
}

class FeedbackCampaignSubmit extends FeedbackCampaignEvent {
  final FeedbackToCampaignDTO organizationFeedback;

  const FeedbackCampaignSubmit({
    required this.organizationFeedback,
  });

  @override
  List<Object> get props => [organizationFeedback];
}

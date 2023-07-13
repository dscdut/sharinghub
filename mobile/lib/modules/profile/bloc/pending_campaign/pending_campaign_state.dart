part of 'pending_campaign_bloc.dart';

class PendingCampaignState extends Equatable {
  final HandleStatus status;
  final String? errorMessage;
  final List<CampaignModel> campaigns;

  const PendingCampaignState(
    this.status, {
    this.errorMessage,
    this.campaigns = const [],
  });

  const PendingCampaignState.initial()
      : status = HandleStatus.initial,
        campaigns = const [],
        errorMessage = null;

  const PendingCampaignState.success({
    required List<CampaignModel> campaigns,
  }) : this(
          HandleStatus.success,
          campaigns: campaigns,
        );

  const PendingCampaignState.failure({
    required String errorMessage,
  }) : this(
          HandleStatus.error,
          errorMessage: errorMessage,
        );

  PendingCampaignState copyWith({
    HandleStatus? status,
    String? errorMessage,
    List<CampaignModel>? campaigns,
  }) {
    return PendingCampaignState(
      status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      campaigns: campaigns ?? this.campaigns,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage ?? '',
        campaigns,
      ];
}

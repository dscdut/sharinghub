part of 'campaign_management.bloc.dart';

class CampaignManagementState extends Equatable {
  final HandleStatus status;
  final List<CampaignModel> campaigns;

  const CampaignManagementState({
    this.status = HandleStatus.initial,
    this.campaigns = const [],
  });

  @override
  List<Object> get props => [status, campaigns];

  CampaignManagementState copyWith({
    HandleStatus? status,
    List<CampaignModel>? campaigns,
  }) {
    return CampaignManagementState(
      status: status ?? this.status,
      campaigns: campaigns ?? this.campaigns,
    );
  }
}

part of 'campaign_detail.bloc.dart';

enum CampaignDetailStatus {
  initial,
  getLoading,
  getSuccess,
  getFailed,
  joinLoading,
  joinSuccess,
  joinFailed
}

class CampaignDetailState extends Equatable {
  final CampaignDetailStatus status;
  final CampaignModel? campaignModel;
  final String? error;

  const CampaignDetailState({
    this.campaignModel,
    this.status = CampaignDetailStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [campaignModel, status, error];

  CampaignDetailState copyWith({
    CampaignDetailStatus? status,
    CampaignModel? campaign,
    String? error,
  }) {
    return CampaignDetailState(
      status: status ?? this.status,
      campaignModel: campaign ?? campaignModel,
      error: error ?? this.error,
    );
  }
}

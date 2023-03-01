part of 'campaign.bloc.dart';

class CampaignState extends Equatable {
  final HandleStatus? status;
  final String? error;

  const CampaignState({
    this.status = HandleStatus.initial,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        error,
      ];

  CampaignState copyWith({
    HandleStatus? status,
    String? error,
  }) {
    return CampaignState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

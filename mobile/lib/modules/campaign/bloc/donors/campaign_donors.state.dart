part of 'campaign_donors.bloc.dart';

class CampaignDonorsState extends Equatable {
  const CampaignDonorsState({
    this.status,
  });

  final HandleStatus? status;

  const CampaignDonorsState.initial()
      : this(
          status: HandleStatus.initial,
        );

  CampaignDonorsState copyWith({
    HandleStatus? status,
  }) {
    return CampaignDonorsState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}

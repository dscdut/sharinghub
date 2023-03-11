part of 'explore.bloc.dart';

enum SortType {
  newest,
  nearest;

  String get name {
    switch (this) {
      case SortType.newest:
        return LocaleKeys.home_newest.tr();
      case SortType.nearest:
        return LocaleKeys.home_nearest.tr();
      default:
        return '';
    }
  }
}

class ExploreState extends Equatable {
  final HandleStatus status;
  final String? error;
  final List<CampaignModel>? campaigns;
  final SortType? sortType;

  const ExploreState({
    this.status = HandleStatus.initial,
    this.error,
    this.campaigns,
    this.sortType = SortType.newest,
  });

  const ExploreState.loading({
    this.error,
    this.campaigns,
    this.sortType,
  }) : status = HandleStatus.loading;

  const ExploreState.getSuccess({
    required this.campaigns,
    this.sortType,
  })  : status = HandleStatus.success,
        error = null;

  const ExploreState.getFailure(
    this.sortType, {
    required this.error,
  })  : status = HandleStatus.error,
        campaigns = const [];

  ExploreState copyWith({
    HandleStatus? status,
    String? error,
    List<CampaignModel>? campaigns,
    SortType? sortType,
  }) {
    return ExploreState(
      status: status ?? this.status,
      error: error ?? this.error,
      campaigns: campaigns ?? this.campaigns,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        campaigns,
        sortType,
      ];
}

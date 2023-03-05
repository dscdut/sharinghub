part of 'home.bloc.dart';

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

class HomeState extends Equatable {
  final HandleStatus status;
  final String? error;
  final List<CampaignModel>? campaigns;
  final SortType? sortType;

  const HomeState({
    this.status = HandleStatus.initial,
    this.error,
    this.campaigns,
    this.sortType = SortType.newest,
  });

  const HomeState.loading({
    this.error,
    this.campaigns,
    this.sortType,
  }) : status = HandleStatus.loading;

  const HomeState.getSuccess({
    required this.campaigns,
    this.sortType,
  })  : status = HandleStatus.success,
        error = null;

  const HomeState.getFailure(
    this.sortType, {
    required this.error,
  })  : status = HandleStatus.error,
        campaigns = const [];

  HomeState copyWith({
    HandleStatus? status,
    String? error,
    List<CampaignModel>? campaigns,
    SortType? sortType,
  }) {
    return HomeState(
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

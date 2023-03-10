part of 'explore.bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class ExploreListCampainsGet extends ExploreEvent {}

class ExploreSortTypeChange extends ExploreEvent {
  final SortType sortType;

  const ExploreSortTypeChange(this.sortType);

  @override
  List<Object> get props => [sortType];
}

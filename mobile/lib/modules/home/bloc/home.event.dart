part of 'home.bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeListCampainsGet extends HomeEvent {}

class HomeSortTypeChange extends HomeEvent {
  final SortType sortType;

  const HomeSortTypeChange(this.sortType);

  @override
  List<Object> get props => [sortType];
}

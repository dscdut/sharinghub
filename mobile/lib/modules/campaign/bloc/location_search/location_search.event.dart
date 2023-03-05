part of 'location_search.bloc.dart';

abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  @override
  List<Object> get props => [];
}

class LocationSearchChanged extends LocationSearchEvent {
  final String input;

  const LocationSearchChanged({required this.input});

  @override
  List<Object> get props => [input];
}

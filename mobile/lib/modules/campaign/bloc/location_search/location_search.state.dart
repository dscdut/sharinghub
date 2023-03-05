part of 'location_search.bloc.dart';

class LocationSearchState extends Equatable {
  final List<PlaceModel> places;

  const LocationSearchState({this.places = const []});

  @override
  List<Object> get props => [places];

  LocationSearchState copyWith({
    List<PlaceModel>? places,
  }) {
    return LocationSearchState(
      places: places ?? this.places,
    );
  }
}

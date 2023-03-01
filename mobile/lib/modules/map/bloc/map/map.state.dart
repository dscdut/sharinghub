part of 'map.bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.myLocation,
    this.markers,
  });

  final LatLng? myLocation;
  final Set<Marker>? markers;

  const MapState.initial()
      : this(
          myLocation: const LatLng(18.635370, 105.737148),
          markers: const {},
        );

  MapState copyWith({
    LatLng? myLocation,
    Set<Marker>? markers,
  }) {
    return MapState(
      myLocation: myLocation ?? this.myLocation,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [myLocation];
}

class MapGetLocationSuccess extends MapState {
  const MapGetLocationSuccess({
    required LatLng myLocation,
    required Set<Marker> markers,
  }) : super(myLocation: myLocation, markers: markers);
}

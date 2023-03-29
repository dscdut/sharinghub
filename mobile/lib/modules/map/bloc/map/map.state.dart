part of 'map.bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.myLocation,
    this.markers,
    this.error,
  });

  final LatLng? myLocation;
  final Set<Marker>? markers;
  final String? error;

  const MapState.initial()
      : this(
          myLocation: const LatLng(18.635370, 105.737148),
          markers: const {},
        );

  MapState copyWith({
    LatLng? myLocation,
    Set<Marker>? markers,
    String? error,
  }) {
    return MapState(
      myLocation: myLocation ?? this.myLocation,
      markers: markers ?? this.markers,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        myLocation,
        markers,
        error,
      ];
}

class MapGetLocationSuccess extends MapState {
  const MapGetLocationSuccess({
    required LatLng myLocation,
    required Set<Marker> markers,
  }) : super(myLocation: myLocation, markers: markers);
}

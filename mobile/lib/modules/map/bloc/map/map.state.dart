part of 'map.bloc.dart';

@freezed
class MapState extends Equatable with _$MapState {
  factory MapState({
    LatLng? myLocation,
    Set<Marker>? markers,
    String? error,
  }) = _MapState;

  const MapState._();

  // initial state
  factory MapState.initial() => MapState(
        myLocation: defaultLocation,
        markers: const {},
      );

  @override
  List<Object?> get props => [
        myLocation,
        markers,
        error,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapState extends Equatable {
  const GoogleMapState({
    this.myLocation,
    this.marker,
  });

  final LatLng? myLocation;
  final Set<Marker>? marker;

  const GoogleMapState.initial()
      : this(
          myLocation: const LatLng(20, 20),
          marker: const {},
        );

  const GoogleMapState.located({
    required LatLng location,
  }) : this(myLocation: location);

  const GoogleMapState.marked({
    required Set<Marker> marker,
  }) : this(marker: marker);

  @override
  List<Object?> get props => [myLocation];
}

// class GoogleMapSuccess extends GoogleMapState {
//   const GoogleMapSuccess.myLocation({
//     required LatLng myLocation,
//   }) : super(myLocation: myLocation);

//   const GoogleMapSuccess({
//     required super.myLocation,
//     required super.marker,
//   });
// }

// class GoogleMapAddMarkers extends GoogleMapState {
//   const GoogleMapAddMarkers({
//     required super.myLocation,
//     required markers,
//   });
// }

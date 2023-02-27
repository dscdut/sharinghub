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
          myLocation: const LatLng(18.635370, 105.737148),
          marker: const {},
        );

  GoogleMapState copyWith({
    LatLng? myLocation,
    Set<Marker>? marker,
  }) {
    return GoogleMapState(
      myLocation: myLocation ?? this.myLocation,
      marker: marker ?? this.marker,
    );
  }

  @override
  List<Object?> get props => [myLocation];
}

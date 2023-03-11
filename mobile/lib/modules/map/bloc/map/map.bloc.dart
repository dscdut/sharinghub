import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

part 'map.state.dart';
part 'map.event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(
          const MapState.initial(),
        ) {
    on<MapPermissionRequest>(_onRequestPermission);
    on<MapMarkersGet>(_onGetMarkers);
    add(MapPermissionRequest());
    add(const MapMarkersGet());
  }

  Future<LatLng> _getMyLocation() async {
    try {
      final Position userPosition = await Geolocator.getCurrentPosition();

      return LatLng(userPosition.latitude, userPosition.longitude);
    } catch (err) {
      log('Error in get user location');

      return defaultLocation;
    }
  }

  Future<void> _onRequestPermission(
    MapPermissionRequest event,
    Emitter<MapState> emiiter,
  ) async {
    final bool isGranted = await Permission.location.isGranted;

    if (!isGranted) {
      await Permission.location.request();
    }

    emiiter(
      MapGetLocationSuccess(
        myLocation: await _getMyLocation(),
        markers: state.markers ?? const {},
      ),
    );
  }

  Future<void> _onGetMarkers(
    MapMarkersGet event,
    Emitter<MapState> emiiter,
  ) async {
    Set<Marker> markers = {
      const Marker(
        markerId: MarkerId('value'),
        position: LatLng(18.635370, 105.737148),
      ),
      const Marker(markerId: MarkerId('value2'), position: LatLng(18.6, 105.8)),
    };
    emiiter(state.copyWith(markers: markers));
  }
}

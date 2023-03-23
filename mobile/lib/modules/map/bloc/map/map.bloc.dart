import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:mobile/data/repositories/place.repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

part 'map.state.dart';
part 'map.event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final PlaceRepository _placeRepository;

  MapBloc({
    required PlaceRepository placeRepository,
  })  : _placeRepository = placeRepository,
        super(
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
    try {
      final response = await _placeRepository.getCoordinates();
      emiiter(
        state.copyWith(
          markers: response
              .map(
                (e) => Marker(
                  markerId: MarkerId(e.id.toString()),
                  position: LatLng(e.coordinate.lat, e.coordinate.lng),
                ),
              )
              .toSet(),
        ),
      );
    } catch (e) {
      log('Error in get markers');
    }
  }
}

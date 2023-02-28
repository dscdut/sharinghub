import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

part 'map.state.dart';
part 'map.event.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(
          const MapState.initial(),
        ) {
    on<MapPermissionRequest>(_requestPermission);
    on<MapMarkersGet>(_getMarkers);
    add(MapPermissionRequest());
    add(const MapMarkersGet());
  }

  Future<LatLng> _getMyLocation() async =>
      Geolocator.getCurrentPosition().then((postion) async {
        await Future.delayed(const Duration(milliseconds: 2000));
        return LatLng(
          postion.latitude,
          postion.longitude,
        );
      });

  Future<void> _requestPermission(
    MapPermissionRequest event,
    Emitter<MapState> emiiter,
  ) async {
    if (await Permission.location.request().isDenied) {
      _requestPermission(event, emiiter);
    } else {
      emiiter(
        MapGetLocationSuccess(
          myLocation: await _getMyLocation(),
          markers: state.markers ?? const {},
        ),
      );
    }
  }

  Future<void> _getMarkers(
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

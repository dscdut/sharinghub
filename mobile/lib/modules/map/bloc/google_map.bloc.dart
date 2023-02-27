import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/modules/map/bloc/google_map.event.dart';
import 'package:mobile/modules/map/bloc/google_map.state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc()
      : super(
          const GoogleMapState.initial(),
        ) {
    on<GoogleMapRequetPermission>(_requestPermission);
    on<GoogleMapGetMarkers>(_getMarkers);
    add(GoogleMapRequetPermission());
    add(const GoogleMapGetMarkers());
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
    GoogleMapRequetPermission event,
    Emitter<GoogleMapState> emiiter,
  ) async {
    if (await Permission.location.request().isDenied) {
      _requestPermission(event, emiiter);
    } else {
      emiiter(
        state.copyWith(
          myLocation: await _getMyLocation(),
        ),
      );
    }
  }

  Future<void> _getMarkers(
    GoogleMapGetMarkers event,
    Emitter<GoogleMapState> emiiter,
  ) async {
    Set<Marker> marker = {
      const Marker(
        markerId: MarkerId('value'),
        position: LatLng(18.635370, 105.737148),
      ),
      const Marker(markerId: MarkerId('value2'), position: LatLng(18.6, 105.8)),
    };
    emiiter(state.copyWith(marker: marker));
  }
}

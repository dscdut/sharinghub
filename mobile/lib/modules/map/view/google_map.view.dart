import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/modules/map/bloc/google_map.bloc.dart';
import 'package:mobile/modules/map/bloc/google_map.state.dart';
import 'package:mobile/modules/map/view/map_bottom_sheet.view.dart';

class GoogleMapPage extends StatelessWidget {
  GoogleMapPage({super.key});
  Completer<GoogleMapController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoogleMapBloc(),
      child: BlocListener<GoogleMapBloc, GoogleMapState>(
        listener: (context, state) async {
          GoogleMapController googleMapController = await controller.future;
          googleMapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              state.myLocation ?? const LatLng(20, 20),
              16,
            ),
          );
        },
        child: _GoogleMapView(
          controller: controller,
        ),
      ),
    );
  }
}

class _GoogleMapView extends StatelessWidget {
  _GoogleMapView({
    required this.controller,
  });
  late Completer<GoogleMapController> controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: BlocBuilder<GoogleMapBloc, GoogleMapState>(
        builder: (bcontext, state) => GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(20, 20),
            zoom: 16,
          ),
          onMapCreated: (gController) {
            controller.complete(gController);
          },
          myLocationEnabled: true,
          markers: state.marker
                  ?.map((e) => Marker(
                        markerId: e.markerId,
                        position: e.position,
                        onTap: () {
                          _onClickMarker(context);
                        },
                      ))
                  .toSet() ??
              const {},
        ),
      ),
    );
  }

  void _onClickMarker(BuildContext context) {
    showBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ccontext) {
        return const MapBottomSheetView();
      },
    );
  }
}

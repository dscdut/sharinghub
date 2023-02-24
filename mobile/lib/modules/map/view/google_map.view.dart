import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/modules/map/bloc/google_map.bloc.dart';
import 'package:mobile/modules/map/bloc/google_map.state.dart';

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
          googleMapController.moveCamera(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (ccontext) {
              return Container(
                width: double.infinity,
                height: 200,
                color: Colors.red,
              );
            },
          );
        },
        child: const Icon(Icons.add),
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
          myLocationButtonEnabled: false,
          markers: state.marker ?? const {},
        ),
      ),
    );
  }
}

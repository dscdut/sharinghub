import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:mobile/modules/map/bloc/bottom_sheet_bloc/map_bottom_sheet.bloc.dart';
import 'package:mobile/modules/map/bloc/map/map.bloc.dart';
import 'package:mobile/modules/map/widgets/map_bottom_sheet.view.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});
  final Completer<GoogleMapController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
          create: (context) => MapBottomsheetBloc(),
        )
      ],
      child: BlocListener<MapBloc, MapState>(
        listener: (context, state) => _listenMapStateChanged(context, state),
        child: _MapView(
          controller: controller,
        ),
      ),
    );
  }

  Future<void> _listenMapStateChanged(
    BuildContext context,
    MapState state,
  ) async {
    if (state is MapGetLocationSuccess) {
      GoogleMapController googleMapController = await controller.future;
      googleMapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          state.myLocation ?? defaultLocation,
          9,
        ),
      );
    }
  }
}

class _MapView extends StatelessWidget {
  const _MapView({
    required this.controller,
  });
  final Completer<GoogleMapController> controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (bcontext, state) => GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: defaultLocation,
            zoom: 5,
          ),
          onMapCreated: (gController) {
            controller.complete(gController);
          },
          mapToolbarEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          markers: state.markers
                  ?.map(
                    (e) => Marker(
                      markerId: e.markerId,
                      position: e.position,
                      onTap: () {
                        _onClickMarker(context);
                      },
                    ),
                  )
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
        return BlocProvider.value(
          value: context.read<MapBottomsheetBloc>(),
          child: const CampaignBottomSheet(),
        );
      },
    );
  }
}

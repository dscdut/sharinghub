import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/constants.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/di/di.dart';
import 'package:mobile/modules/map/bloc/bottom_sheet_bloc/map_bottom_sheet.bloc.dart';
import 'package:mobile/modules/map/bloc/map/map.bloc.dart';
import 'package:mobile/modules/map/widgets/map_bottom_sheet.widget.dart';
import 'package:mobile/modules/map/widgets/map_search_button.widget.dart';

class MapPage extends StatelessWidget {
  final Completer<GoogleMapController> controller = Completer();

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
          create: (context) => MapBottomsheetBloc(
            campaignRepository: getIt.get<CampaignRepository>(),
          ),
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
  final Completer<GoogleMapController> controller;

  const _MapView({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MapBloc, MapState>(
          builder: (bcontext, state) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: defaultLocation,
                    zoom: 5,
                  ),
                  onMapCreated: (gController) {
                    controller.complete(gController);
                  },
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  buildingsEnabled: false,
                  markers: state.markers
                          ?.map(
                            (e) => Marker(
                              markerId: e.markerId,
                              position: e.position,
                              onTap: () {
                                _onClickMarker(context, e.position);
                              },
                            ),
                          )
                          .toSet() ??
                      const {},
                ),
                const MapSearchButtonWidget()
              ],
            );
          },
        ),
      ),
    );
  }

  void _onClickMarker(BuildContext context, LatLng wardLocation) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (ccontext) {
        return BlocProvider.value(
          value: context.read<MapBottomsheetBloc>()
            ..add(MapBottomSheetGetCampaigns(wardLocation: wardLocation)),
          child: const CampaignBottomSheet(),
        );
      },
    );
  }
}

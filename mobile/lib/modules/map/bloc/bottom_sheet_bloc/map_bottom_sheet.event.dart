part of 'map_bottom_sheet.bloc.dart';

abstract class MapBottomSheetEvent extends Equatable {
  const MapBottomSheetEvent();

  @override
  List<Object?> get props => [];
}

class MapBottomSheetGetCampaigns extends MapBottomSheetEvent {
  final LatLng wardLocation;

  const MapBottomSheetGetCampaigns({required this.wardLocation});

  @override
  List<Object?> get props => [wardLocation];
}

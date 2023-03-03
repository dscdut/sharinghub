part of 'map_bottom_sheet.bloc.dart';

class MapBottomSheetState extends Equatable {
  final HandleStatus status;
  final List<CampaignModel> campaigns;
  final String? error;

  const MapBottomSheetState._({
    this.status = HandleStatus.initial,
    this.error,
    this.campaigns = const [],
  });

  const MapBottomSheetState.initial() : this._(status: HandleStatus.initial);

  const MapBottomSheetState.loading() : this._(status: HandleStatus.loading);

  const MapBottomSheetState.success({
    required List<CampaignModel> campaigns,
  }) : this._(status: HandleStatus.success, campaigns: campaigns);

  const MapBottomSheetState.error({
    required String error,
  }) : this._(
          status: HandleStatus.error,
          error: error,
        );

  @override
  List<Object?> get props => [status, error];
}

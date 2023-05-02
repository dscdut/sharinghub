part of 'map_bottom_sheet.bloc.dart';

@freezed
class MapBottomSheetState extends Equatable with _$MapBottomSheetState {
  factory MapBottomSheetState({
    required HandleStatus status,
    String? error,
    required List<CampaignModel> campaigns,
  }) = _MapBottomSheetState;

  const MapBottomSheetState._();

  // initial state
  factory MapBottomSheetState.initial() => MapBottomSheetState(
        status: HandleStatus.initial,
        campaigns: const [],
      );

  // loading state
  factory MapBottomSheetState.loading() => MapBottomSheetState(
        status: HandleStatus.loading,
        campaigns: const [],
      );

  // success state
  factory MapBottomSheetState.success({
    required List<CampaignModel> campaigns,
  }) =>
      MapBottomSheetState(
        status: HandleStatus.success,
        campaigns: campaigns,
      );

  // error state
  factory MapBottomSheetState.error({
    required String error,
  }) =>
      MapBottomSheetState(
        status: HandleStatus.error,
        error: error,
        campaigns: const [],
      );

  @override
  List<Object?> get props => [
        status,
        error,
        campaigns,
      ];
}

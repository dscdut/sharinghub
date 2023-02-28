part of 'map_bottom_sheet.bloc.dart';

class MapBottomsheetState extends Equatable {
  final HandleStatus? status;
  final String? error;

  const MapBottomsheetState()
      : status = HandleStatus.loading,
        error = null;

  const MapBottomsheetState.success()
      : status = HandleStatus.success,
        error = null;

  const MapBottomsheetState.error({
    required String this.error,
  }) : status = HandleStatus.error;

  @override
  List<Object?> get props => [status, error];
}

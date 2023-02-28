part of 'map_bottom_sheet.bloc.dart';

abstract class MapBottomsheetEvent extends Equatable {
  const MapBottomsheetEvent();

  @override
  List<Object?> get props => [];
}

class MapBottomsheetGetProjects extends MapBottomsheetEvent {}

import 'package:bloc/bloc.dart';
import 'package:mobile/modules/map/bottom_sheet_bloc/map_bottom_sheet.event.dart';
import 'package:mobile/modules/map/bottom_sheet_bloc/map_bottom_sheet.state.dart';

class MapBottomsheetBloc
    extends Bloc<MapBottomsheetEvent, MapBottomsheetState> {
  MapBottomsheetBloc() : super(const MapBottomsheetState()) {
    on<MapBottomsheetGetProjects>(_getProjects);
    add(MapBottomsheetGetProjects());
  }

  Future<void> _getProjects(
    MapBottomsheetEvent event,
    Emitter<MapBottomsheetState> emitter,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    emitter(const MapBottomsheetState.success());
  }
}

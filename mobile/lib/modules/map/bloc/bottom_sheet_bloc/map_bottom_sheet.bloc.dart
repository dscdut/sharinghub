import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';

part 'map_bottom_sheet.event.dart';
part 'map_bottom_sheet.state.dart';

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

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/data/models/place.model.dart';
import 'package:mobile/data/repositories/place.repository.dart';

part 'location_search.event.dart';
part 'location_search.state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final PlaceRepository _placeRepository;

  LocationSearchBloc({required PlaceRepository placeRepository})
      : _placeRepository = placeRepository,
        super(const LocationSearchState()) {
    on<LocationSearchChanged>(_onChangedSearch);
  }

  Future<void> _onChangedSearch(
    LocationSearchChanged event,
    Emitter<LocationSearchState> emit,
  ) async {
    try {
      final List<PlaceModel> places =
          await _placeRepository.getSuggestPlaces(event.input);

      emit(state.copyWith(places: places));
    } catch (err) {
      emit(state.copyWith(places: []));
    }
  }
}

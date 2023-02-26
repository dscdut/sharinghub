import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/home_module/home_project.model.dart';
import 'package:mobile/data/repositories/project.repository.dart';

part 'home.event.dart';
part 'home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProjectRepository _repository;

  HomeBloc({
    required ProjectRepository repository,
  })  : _repository = repository,
        super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeGetList>(_getHomeList);
    add(HomeGetList());
  }
  Future<void> _getHomeList(
    HomeGetList event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(const HomeState.loading());
    final result = await _repository.getHomeProject();
    emitter(HomeState.getSuccess(items: result));
  }
}

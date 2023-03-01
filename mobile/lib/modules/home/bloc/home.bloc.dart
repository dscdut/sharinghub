import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'home.event.dart';
part 'home.state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CampaignRepository _repository;

  HomeBloc({
    required CampaignRepository repository,
  })  : _repository = repository,
        super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<HomeListCampainsGet>(_getHomeList);
    on<HomeSortTypeChange>(_changeSortType);
    add(HomeListCampainsGet());
  }
  Future<void> _getHomeList(
    HomeListCampainsGet event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(
      HomeState.loading(
        sortType: state.sortType,
      ),
    );
    final result = await _repository.getHomeProject();
    emitter(
      HomeState.getSuccess(
        campaigns: result,
        sortType: state.sortType,
      ),
    );
  }

  Future<void> _changeSortType(
    HomeSortTypeChange event,
    Emitter<HomeState> emitter,
  ) async {
    emitter(state.copyWith(sortType: event.sortType));
    add(HomeListCampainsGet());
  }
}

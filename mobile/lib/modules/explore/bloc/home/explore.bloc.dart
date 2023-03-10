import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'explore.event.dart';
part 'explore.state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final CampaignRepository _repository;

  ExploreBloc({
    required CampaignRepository repository,
  })  : _repository = repository,
        super(const ExploreState()) {
    on<ExploreEvent>((event, emit) {});
    on<ExploreListCampainsGet>(_getHomeList);
    on<ExploreSortTypeChange>(_changeSortType);
    add(ExploreListCampainsGet());
  }
  Future<void> _getHomeList(
    ExploreListCampainsGet event,
    Emitter<ExploreState> emitter,
  ) async {
    emitter(
      ExploreState.loading(
        sortType: state.sortType,
      ),
    );
    final result = await _repository.getCampaigns();
    emitter(
      ExploreState.getSuccess(
        campaigns: result,
        sortType: state.sortType,
      ),
    );
  }

  Future<void> _changeSortType(
    ExploreSortTypeChange event,
    Emitter<ExploreState> emitter,
  ) async {
    emitter(state.copyWith(sortType: event.sortType));
    add(ExploreListCampainsGet());
  }
}

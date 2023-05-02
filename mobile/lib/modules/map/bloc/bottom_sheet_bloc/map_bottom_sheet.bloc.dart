import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';
import 'package:mobile/generated/locale_keys.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_bottom_sheet.event.dart';
part 'map_bottom_sheet.state.dart';
part 'map_bottom_sheet.bloc.freezed.dart';

class MapBottomsheetBloc
    extends Bloc<MapBottomSheetEvent, MapBottomSheetState> {
  final CampaignRepository _campaignRepository;

  MapBottomsheetBloc({required CampaignRepository campaignRepository})
      : _campaignRepository = campaignRepository,
        super(MapBottomSheetState.initial()) {
    on<MapBottomSheetGetCampaigns>(_onGetCampaigns);
  }

  Future<void> _onGetCampaigns(
    MapBottomSheetGetCampaigns event,
    Emitter<MapBottomSheetState> emit,
  ) async {
    emit(
      MapBottomSheetState.loading(),
    );

    try {
      final List<CampaignModel> campaigns =
          await _campaignRepository.getCampaignsByLocation(event.wardLocation);

      emit(MapBottomSheetState.success(campaigns: campaigns));
    } catch (err) {
      emit(
        MapBottomSheetState.error(
          error: LocaleKeys.texts_error_get_campaigns.tr(),
        ),
      );
    }
  }
}

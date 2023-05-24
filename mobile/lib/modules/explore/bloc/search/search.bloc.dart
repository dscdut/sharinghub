import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/common/constants/handle_status.enum.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/repositories/address.repository.dart';
import 'package:mobile/data/repositories/campaign.repository.dart';

part 'search.event.dart';
part 'search.state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CampaignRepository _campaignRepository;
  final AddressRepository _addressRepository;

  SearchBloc({
    required CampaignRepository campaignRepository,
    required AddressRepository addressRepository,
  })  : _campaignRepository = campaignRepository,
        _addressRepository = addressRepository,
        super(SearchState.initial()) {
    on<SearchListCampainsGet>(_onSearchSubmit);

    //Keyword changed
    on<SearchKeywordChanged>(_onKeywordChanged);

    // Province
    on<SearchListProvincesGet>(_onGetProvinces);
    on<SearchProvinceSelected>(_onProvinceSelected);

    // District
    on<SearchDistrictSelected>(_onDistricSelected);
    on<SearchListDistrictsGet>(_onGetDistricts);

    // Ward
    on<SearchListWardsGet>(_onGetWards);
    on<SearchWardSelected>(_onWardSelected);

    add(SearchListProvincesGet());
  }

  Future<void> _onSearchSubmit(
    SearchListCampainsGet event,
    Emitter<SearchState> emitter,
  ) async {
    emitter(state.copyWith(status: HandleStatus.loading));
    try {
      emitter(
        state.copyWith(
          campaigns: await _campaignRepository.searchCampaigns(
            (state.provinceIndex > -1)
                ? state.provinces[state.provinceIndex].provinceCode
                : null,
            (state.districtIndex > -1)
                ? state.districts[state.districtIndex].districtCode
                : null,
            (state.wardIndex > -1)
                ? state.wards[state.wardIndex].wardCode
                : null,
            state.keyword, // check if dropdown not selected
          ),
          status: HandleStatus.success,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          status: HandleStatus.error,
          error: 'Error',
        ),
      );
    }
  }

  Future<void> _onGetProvinces(
    SearchListProvincesGet event,
    Emitter<SearchState> emitter,
  ) async {
    emitter(state.copyWith(provinceStatus: HandleStatus.loading));
    try {
      final result = await _addressRepository.getPronvinces();
      result.insert(0, ProvinceModel.all());
      emitter(
        state.copyWith(
          provinces: result,
          provinceStatus: HandleStatus.success,
          provinceIndex: 0,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          provinceStatus: HandleStatus.error,
          error: 'Error',
        ),
      );
    }
  }

  Future<void> _onProvinceSelected(
    SearchProvinceSelected event,
    Emitter<SearchState> emitter,
  ) async {
    emitter(
      state.copyWith(
        provinceIndex: event.provinceCode,
        districtIndex: -1,
        wardIndex: -1,
      ),
    );
    add(SearchListDistrictsGet());
  }

  // District

  Future<void> _onGetDistricts(
    SearchListDistrictsGet event,
    Emitter<SearchState> emitter,
  ) async {
    if (state.provinceIndex == 0) {
      return;
    }
    emitter(
      state.copyWith(
        districtStatus: HandleStatus.loading,
      ),
    );
    try {
      final result = await _addressRepository.getDistricts(
        state.provinces[state.provinceIndex].provinceCode,
      );
      result.insert(0, DistrictModel.all());
      emitter(
        state.copyWith(
          districts: result,
          districtStatus: HandleStatus.success,
          districtIndex: 0,
        ),
      );
    } catch (e) {
      emitter(
        state.copyWith(
          districtStatus: HandleStatus.error,
          error: 'Error',
        ),
      );
    }
  }

  Future<void> _onDistricSelected(
    SearchDistrictSelected event,
    Emitter<SearchState> emitter,
  ) async {
    emitter(
      state.copyWith(
        districtIndex: event.districtCode,
        wardIndex: -1,
      ),
    );
    add(const SearchListCampainsGet());
    add(SearchListWardsGet());
  }

  // Ward

  Future<void> _onWardSelected(
    SearchWardSelected event,
    Emitter<SearchState> emitter,
  ) async {
    emitter(
      state.copyWith(
        wardIndex: event.wardCode,
      ),
    );
  }

  Future<void> _onGetWards(
    SearchListWardsGet event,
    Emitter<SearchState> emitter,
  ) async {
    if (state.districtIndex == 0) {
      return;
    }
    emitter(
      state.copyWith(
        wardStatus: HandleStatus.loading,
      ),
    );
    try {
      final result = await _addressRepository.getWards(
        state.districts[state.districtIndex].districtCode,
      );
      result.insert(0, WardModel.all());
      emitter(
        state.copyWith(
          wards: result,
          wardStatus: HandleStatus.success,
          wardIndex: 0,
        ),
      );
      add(const SearchListCampainsGet());
    } catch (e) {
      emitter(
        state.copyWith(
          wardStatus: HandleStatus.error,
          error: 'Error',
        ),
      );
    }
  }

  void _onKeywordChanged(
    SearchKeywordChanged event,
    Emitter<SearchState> emitter,
  ) {
    emitter(
      state.copyWith(
        keyword: event.keyword,
      ),
    );
  }
}

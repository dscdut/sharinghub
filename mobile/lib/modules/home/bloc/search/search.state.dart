part of 'search.bloc.dart';

class SearchState extends Equatable {
  final HandleStatus status;
  final String? error;
  final List<CampaignModel>? campaigns;

  // Province state
  final HandleStatus provinceStatus;
  final List<ProvinceModel> provinces;
  final int provinceIndex;

  //District state
  final HandleStatus districtStatus;
  final List<DistrictModel> districts;
  final int districtIndex;

  //Ward state
  final HandleStatus wardStatus;
  final List<WardModel> wards;
  final int wardIndex;

  bool get isLoading => status.isLoading;

  bool get isSuccess => status.isSuccess;

  bool get isError => status.isError;

  bool get isInitial => status.isInitial;

  const SearchState(
    this.status,
    this.error,
    this.campaigns,
    this.provinces,
    this.provinceStatus,
    this.provinceIndex,
    this.districtStatus,
    this.districts,
    this.districtIndex,
    this.wardStatus,
    this.wards,
    this.wardIndex,
  );

  factory SearchState.initial() => const SearchState(
        HandleStatus.initial,
        null,
        null,
        [],
        HandleStatus.initial,
        -1,
        HandleStatus.initial,
        [],
        -1,
        HandleStatus.initial,
        [],
        -1,
      );

  @override
  List<Object?> get props => [
        status,
        error,
        campaigns,
        provinces,
        provinceStatus,
        provinceIndex,
        districtStatus,
        districts,
        districtIndex,
        wardStatus,
        wards,
        wardIndex,
      ];

  SearchState copyWith({
    HandleStatus? status,
    String? error,
    List<CampaignModel>? campaigns,
    List<ProvinceModel>? provinces,
    HandleStatus? provinceStatus,
    int? provinceIndex,
    HandleStatus? districtStatus,
    List<DistrictModel>? districts,
    int? districtIndex,
    HandleStatus? wardStatus,
    List<WardModel>? wards,
    int? wardIndex,
  }) {
    return SearchState(
      status ?? this.status,
      error ?? this.error,
      campaigns ?? this.campaigns,
      provinces ?? this.provinces,
      provinceStatus ?? this.provinceStatus,
      provinceIndex ?? this.provinceIndex,
      districtStatus ?? this.districtStatus,
      districts ?? this.districts,
      districtIndex ?? this.districtIndex,
      wardStatus ?? this.wardStatus,
      wards ?? this.wards,
      wardIndex ?? this.wardIndex,
    );
  }
}

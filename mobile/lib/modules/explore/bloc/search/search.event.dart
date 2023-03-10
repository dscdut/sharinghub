part of 'search.bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchListCampainsGet extends SearchEvent {
  final String keyword;

  const SearchListCampainsGet({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}

// Province

class SearchListProvincesGet extends SearchEvent {}

class SearchProvinceSelected extends SearchEvent {
  final int provinceCode;

  const SearchProvinceSelected({
    required this.provinceCode,
  });

  @override
  List<Object?> get props => [provinceCode];
}

// District

class SearchListDistrictsGet extends SearchEvent {}

class SearchDistrictSelected extends SearchEvent {
  final int districtCode;

  const SearchDistrictSelected({
    required this.districtCode,
  });

  @override
  List<Object?> get props => [districtCode];
}

// Ward

class SearchListWardsGet extends SearchEvent {}

class SearchWardSelected extends SearchEvent {
  final int wardCode;

  const SearchWardSelected({
    required this.wardCode,
  });

  @override
  List<Object?> get props => [wardCode];
}

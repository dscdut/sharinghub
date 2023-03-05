// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mobile/data/datasources/campaign.datasource.dart' as _i3;
import 'package:mobile/data/datasources/place.datasource.dart' as _i5;
import 'package:mobile/data/datasources/user.datasource.dart' as _i7;
import 'package:mobile/data/repositories/campaign.repository.dart' as _i4;
import 'package:mobile/data/repositories/place.repository.dart' as _i6;
import 'package:mobile/data/repositories/user.repository.dart' as _i8;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.CampaignDataSource>(() => _i3.CampaignDataSource());
  gh.lazySingleton<_i4.CampaignRepository>(
      () => _i4.CampaignRepository(dataSource: gh<_i3.CampaignDataSource>()));
  gh.lazySingleton<_i5.PlaceDataSource>(() => _i5.PlaceDataSource());
  gh.lazySingleton<_i6.PlaceRepository>(
      () => _i6.PlaceRepository(placeDataSource: gh<_i5.PlaceDataSource>()));
  gh.lazySingleton<_i7.UserDataSource>(() => _i7.UserDataSource());
  gh.lazySingleton<_i8.UserRepository>(
      () => _i8.UserRepository(dataSource: gh<_i7.UserDataSource>()));
  return getIt;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mobile/data/datasources/address.datasource.dart' as _i3;
import 'package:mobile/data/datasources/campaign.datasource.dart' as _i5;
import 'package:mobile/data/datasources/place.datasource.dart' as _i7;
import 'package:mobile/data/datasources/user.datasource.dart' as _i9;
import 'package:mobile/data/repositories/address.repository.dart' as _i4;
import 'package:mobile/data/repositories/campaign.repository.dart' as _i6;
import 'package:mobile/data/repositories/place.repository.dart' as _i8;
import 'package:mobile/data/repositories/user.repository.dart' as _i10;

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
  gh.lazySingleton<_i3.AddressDataSOurce>(() => _i3.AddressDataSOurce());
  gh.lazySingleton<_i4.AddressRepository>(
      () => _i4.AddressRepository(dataSource: gh<_i3.AddressDataSOurce>()));
  gh.lazySingleton<_i5.CampaignDataSource>(() => _i5.CampaignDataSource());
  gh.lazySingleton<_i6.CampaignRepository>(
      () => _i6.CampaignRepository(dataSource: gh<_i5.CampaignDataSource>()));
  gh.lazySingleton<_i7.PlaceDataSource>(() => _i7.PlaceDataSource());
  gh.lazySingleton<_i8.PlaceRepository>(
      () => _i8.PlaceRepository(placeDataSource: gh<_i7.PlaceDataSource>()));
  gh.lazySingleton<_i9.UserDataSource>(() => _i9.UserDataSource());
  gh.lazySingleton<_i10.UserRepository>(
      () => _i10.UserRepository(dataSource: gh<_i9.UserDataSource>()));
  return getIt;
}

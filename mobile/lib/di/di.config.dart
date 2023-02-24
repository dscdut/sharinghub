// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mobile/data/datasources/organization.datasource.dart' as _i3;
import 'package:mobile/data/datasources/personal.datasource.dart' as _i5;
import 'package:mobile/data/datasources/user.datasource.dart' as _i7;
import 'package:mobile/data/repositories/organization.repository.dart' as _i4;
import 'package:mobile/data/repositories/personal.repository.dart' as _i6;
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
  gh.lazySingleton<_i3.OrganizationDataSource>(
      () => _i3.OrganizationDataSource());
  gh.lazySingleton<_i4.OrganizationRepository>(() =>
      _i4.OrganizationRepository(dataSource: gh<_i3.OrganizationDataSource>()));
  gh.lazySingleton<_i5.PersonalDataSource>(() => _i5.PersonalDataSource());
  gh.lazySingleton<_i6.PersonalRepository>(
      () => _i6.PersonalRepository(dataSource: gh<_i5.PersonalDataSource>()));
  gh.lazySingleton<_i7.UserDataSource>(() => _i7.UserDataSource());
  gh.lazySingleton<_i8.UserRepository>(
      () => _i8.UserRepository(dataSource: gh<_i7.UserDataSource>()));
  return getIt;
}

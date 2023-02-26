// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mobile/data/datasources/project.datasource.dart' as _i3;
import 'package:mobile/data/datasources/user.datasource.dart' as _i5;
import 'package:mobile/data/repositories/project.repository.dart' as _i4;
import 'package:mobile/data/repositories/user.repository.dart' as _i6;

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
  gh.lazySingleton<_i3.ProjectDataSource>(() => _i3.ProjectDataSource());
  gh.lazySingleton<_i4.ProjectRepository>(
      () => _i4.ProjectRepository(dataSource: gh<_i3.ProjectDataSource>()));
  gh.lazySingleton<_i5.UserDataSource>(() => _i5.UserDataSource());
  gh.lazySingleton<_i6.UserRepository>(
      () => _i6.UserRepository(dataSource: gh<_i5.UserDataSource>()));
  return getIt;
}

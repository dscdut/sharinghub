import 'package:mobile/data/datasources/user.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserRepository {
  final UserDataSource _dataSource;

  UserRepository({required UserDataSource dataSource})
      : _dataSource = dataSource;

  Future<void> loginByEmail(AuthenticationDTO params) {
    return _dataSource.loginByEmail(params);
  }
}

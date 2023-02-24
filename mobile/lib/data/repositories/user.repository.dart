import 'package:mobile/data/datasources/user.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserRepository {
  final UserDataSource _dataSource;

  UserRepository({required UserDataSource dataSource})
      : _dataSource = dataSource;

  Future<AuthResponseDTO> loginByEmail(LoginDTO params) {
    return _dataSource.loginByEmail(params);
  }

  Future<UserModel> getUserInfo() {
    return _dataSource.getUserInfo();
  }

  Future<AuthResponseDTO> registerByEmail(RegisterDTO params) {
    return _dataSource.registerByEmail(params);
  }
}

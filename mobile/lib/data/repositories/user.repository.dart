import 'package:mobile/data/datasources/user.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserRepository {
  final UserDataSource _dataSource;

  UserRepository({required UserDataSource dataSource})
      : _dataSource = dataSource;

  Future<AuthResponseDTO> loginByEmail(SubmitLoginDTO params) {
    return _dataSource.loginByEmail(params);
  }

  Future<bool> registerByEmail(SubmitRegisterDTO params) {
    return _dataSource.registerByEmail(params);
  }

  Future<UserModel> getUserInfo() {
    return _dataSource.getUserInfo();
  }

  Future<UserModel> getUserProfile() {
    return _dataSource.getUserProfile();
  }
}

import 'package:mobile/data/datasources/local/user_local.datasource.dart';
import 'package:mobile/data/datasources/remote/user_remote.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/dtos/set_user.dto.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserRepository {
  final UserLocalDataSource _localDataSource;
  final UserRemoteDataSource _remoteDataSource;

  UserRepository({
    required UserRemoteDataSource dataSource,
    required UserLocalDataSource localDataSource,
  })  : _remoteDataSource = dataSource,
        _localDataSource = localDataSource;

  Future<LoginResponseDTO> loginByEmail(SubmitLoginDTO params) {
    return _remoteDataSource.loginByEmail(params);
  }

  Future<void> registerByEmail(SubmitRegisterDTO params) {
    return _remoteDataSource.registerByEmail(params);
  }

  Future<UserModel> getUserProfile() {
    return _remoteDataSource.getUserProfile();
  }

  UserModel? getUserInfo() {
    return _localDataSource.getUserInfo();
  }

  Future<void> setUser(SetUserDTO params) {
    return _remoteDataSource.setUser(params);
  }

  Future<void> setUserInfo(UserModel user) {
    return _localDataSource.setUserInfo(user);
  }

  Future<void> setUserAuthInfo(LoginResponseDTO? response) {
    return _localDataSource.setUserAuthInfo(response);
  }
}

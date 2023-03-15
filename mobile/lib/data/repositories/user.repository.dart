import 'package:mobile/data/datasources/local/user_local.datasource.dart';
import 'package:mobile/data/datasources/remote/user_remote.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
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

  Future<UserModel> getUserInfo() {
    return _remoteDataSource.getUserInfo();
  }

  Future<UserModel> getUserProfile() {
    return _remoteDataSource.getUserProfile();
  }

  String? getAccessToken() {
    return _localDataSource.getAccessToken();
  }

  Future<void> setTokens(TokenDTO? tokenDTO) {
    return _localDataSource.setTokens(tokenDTO);
  }
}

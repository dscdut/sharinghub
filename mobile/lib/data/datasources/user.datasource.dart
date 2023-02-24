import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserDataSource {
  Future<AuthResponseDTO> loginByEmail(LoginDTO params) async {
    return UserMock.loginByEmail();
    // await DioHelper.post(
    //   Endpoints.login,
    //   data: params.toJson(),
    // );
  }

  Future<UserModel> getUserInfo() async {
    return UserMock.getUserInfo();
  }

  Future<AuthResponseDTO> registerByEmail(RegisterDTO params) async {
    return UserMock.loginByEmail();

    // await DioHelper.post(
    //   Endpoints.register,
    //   data: params.toJson(),
    // );
  }
}

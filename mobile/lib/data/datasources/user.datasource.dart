import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserDataSource {
  Future<AuthResponseDTO> loginByEmail(SubmitLoginDTO params) async {
    return UserMock.loginByEmail();
    // await DioHelper.post(
    //   Endpoints.login,
    //   data: params.toJson(),
    // );
  }

  Future<AuthResponseDTO> registerByEmail(SubmitRegisterDTO params) async {
    return UserMock.loginByEmail();

    // await DioHelper.post(
    //   Endpoints.register,
    //   data: params.toJson(),
    // );
  }

  Future<UserModel> getUserInfo() async {
    return await UserMock.getUserInfo();
  }

  Future<UserModel> getUserProfile() async {
    return UserMock.getUserProfile();
  }
}

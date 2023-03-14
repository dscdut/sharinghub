import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio/dio.helper.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/user.model.dart';

@lazySingleton
class UserDataSource {
  Future<AuthResponseDTO> loginByEmail(SubmitLoginDTO params) async {
    final result = await DioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return AuthResponseDTO.fromJson(result.body);
  }

  Future<bool> registerByEmail(SubmitRegisterDTO params) async {
    final result = await DioHelper.post(
      Endpoints.register,
      data: {
        'email': params.email,
        'fullName': params.name,
        'password': params.password,
        'confirmPassword': params.password
      },
    );
    return result.statusCode == 200;
  }

  Future<UserModel> getUserInfo() async {
    return await UserMock.getUserInfo();
  }

  Future<UserModel> getUserProfile() async {
    return UserMock.getUserProfile();
  }
}

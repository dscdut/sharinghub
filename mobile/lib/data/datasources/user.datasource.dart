import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio/dio.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserDataSource {
  Future<LoginResponseDTO> loginByEmail(AuthenticationDTO params) async {
    final HttpRequestResponse response = await DioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return LoginResponseDTO(
      // user: UserModel.fromJson(response.body['user']),
      email: response.body['email'],
      password: response.body['password'],
      // refreshToken: response.body['data']['token']['refreshToken'],
      // accessToken: response.body['data']['token']['accessToken'],
      // expiresIn: response.body['data']['token']['expiresIn'],
    );
  }
}

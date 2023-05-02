import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/dtos/set_user.dto.dart';

@lazySingleton
class UserRemoteDataSource {
  final DioHelper _dioHelper;

  UserRemoteDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<LoginResponseDTO> loginByEmail(SubmitLoginDTO params) async {
    final result = await _dioHelper.post(
      Endpoints.login,
      data: params.toJson(),
    );

    return LoginResponseDTO.fromJson(result.body);
  }

  Future<void> registerByEmail(SubmitRegisterDTO params) async {
    await _dioHelper.post(
      Endpoints.register,
      data: params.toJson(),
    );
  }

  Future<void> setUser(SetUserDTO params) async {
    await _dioHelper.post(
      Endpoints.user,
      formData: params.toJson(),
    );
  }
}

import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio/dio.helper.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PersonalDataSource {
  Future<void> registerByEmail(PersonalRegisterDTO params) async {
    await DioHelper.post(
      Endpoints.register,
      data: params.toJson(),
    );
  }
}

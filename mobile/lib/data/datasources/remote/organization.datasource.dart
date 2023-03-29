import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/constants/hive_keys.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/models/organization.model.dart';

@lazySingleton
class OrganizationDataSource {
  final DioHelper _dioHelper;
  final Box _userBox;

  const OrganizationDataSource({
    required DioHelper dioHelper,
    @Named(HiveKeys.userBox) required Box userBox,
  })  : _dioHelper = dioHelper,
        _userBox = userBox;

  Future<List<OrganizationModel>> getOrganizations() async {
    return await UserMock.getOrganizations();
  }

  Future<List<OrganizationModel>> getMyOrganizations() async {
    final HttpRequestResponse response =
        await _dioHelper.get(Endpoints.myOrganizations);

    return (response.body as List)
        .map((e) => OrganizationModel.fromJson(e))
        .toList();
  }

  Future<void> setOrganization(SetOrganizationDTO params) async {
    final HttpRequestResponse response = await _dioHelper.post(
      Endpoints.organization,
      formData: params.toJson(),
    );
    _userBox.put(HiveKeys.accessToken, response.body['accessToken']);
  }

  Future<OrganizationModel> getOrganizationInfoById(int organizationId) async {
    return (await UserMock.getOrganizations())[0];
  }
}

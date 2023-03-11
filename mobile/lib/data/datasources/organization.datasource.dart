import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/models/organization.model.dart';

@lazySingleton
class OrganizationDataSource {
  Future<List<OrganizationModel>> getOrganizations() async {
    return await UserMock.getOrganizations();
  }

  Future<void> setOrganization(SetOrganizationDTO params) async {}

  Future<OrganizationModel> getOrganizationInfoById(int organizationId) async {
    return (await UserMock.getOrganizations())[0];
  }
}

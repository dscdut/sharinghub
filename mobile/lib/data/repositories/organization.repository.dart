import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/remote/organization.datasource.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';
import 'package:mobile/data/models/organization.model.dart';

@lazySingleton
class OrganizationRepository {
  final OrganizationDataSource _dataSource;

  OrganizationRepository({required OrganizationDataSource dataSource})
      : _dataSource = dataSource;

  Future<List<OrganizationModel>> getOrganizations() async {
    return _dataSource.getOrganizations();
  }

  Future<List<OrganizationModel>> getMyOrganizations() {
    return _dataSource.getMyOrganizations();
  }

  Future<void> setOrganization(SetOrganizationDTO params) {
    return _dataSource.setOrganization(params);
  }

  Future<OrganizationModel> getOrganizationInfoById(int organizationId) {
    return _dataSource.getOrganizationInfoById(organizationId);
  }
}

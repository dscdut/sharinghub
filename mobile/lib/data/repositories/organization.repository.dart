import 'package:mobile/data/datasources/organization.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OrganizationRepository {
  final OrganizationDataSource _dataSource;

  OrganizationRepository({required OrganizationDataSource dataSource})
      : _dataSource = dataSource;

  Future<void> registerByEmail(OrganizationRegisterDTO params) {
    return _dataSource.registerByEmail(params);
  }
}

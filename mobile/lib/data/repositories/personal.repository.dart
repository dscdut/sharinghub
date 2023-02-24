import 'package:mobile/data/datasources/personal.datasource.dart';
import 'package:mobile/data/dtos/auth.dto.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PersonalRepository {
  final PersonalDataSource _dataSource;

  PersonalRepository({required PersonalDataSource dataSource})
      : _dataSource = dataSource;

  Future<void> registerByEmail(PersonalRegisterDTO params) {
    return _dataSource.registerByEmail(params);
  }
}

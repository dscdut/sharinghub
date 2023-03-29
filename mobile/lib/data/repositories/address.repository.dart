import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/remote/address.datasource.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

@lazySingleton
class AddressRepository {
  final AddressDataSource _dataSource;
  AddressRepository({
    required AddressDataSource dataSource,
  }) : _dataSource = dataSource;

  Future<List<ProvinceModel>> getPronvinces() {
    return _dataSource.getPronvinces();
  }

  Future<List<DistrictModel>> getDistricts() {
    return _dataSource.getDistricts();
  }

  Future<List<WardModel>> getWards() {
    return _dataSource.getWards();
  }
}

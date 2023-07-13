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

  Future<List<DistrictModel>> getDistricts(int provinceCode) {
    return _dataSource.getDistricts(
      provinceCode,
    );
  }

  Future<List<WardModel>> getWards(int districtCode) {
    return _dataSource.getWards(districtCode);
  }
}

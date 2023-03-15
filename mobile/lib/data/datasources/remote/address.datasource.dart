import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/address.mock.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

@lazySingleton
class AddressDataSource {
  Future<List<ProvinceModel>> getPronvinces() async {
    return await AddressMock.getPronvinces();
  }

  Future<List<DistrictModel>> getDistricts() async {
    return await AddressMock.getDistrict();
  }

  Future<List<WardModel>> getWards() async {
    return await AddressMock.getWards();
  }
}

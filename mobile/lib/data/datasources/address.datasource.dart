import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/address.mock.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

@lazySingleton
class AddressDataSOurce {
  Future<List<ProvinceModel>> getPronvinces() async {
    await Future.delayed(const Duration(seconds: 2));
    return AddressMock.getPronvinces();
  }

  Future<List<DistrictModel>> getDistricts() async {
    await Future.delayed(const Duration(seconds: 2));
    return AddressMock.getDistrict();
  }

  Future<List<WardModel>> getWards() async {
    await Future.delayed(const Duration(seconds: 2));
    return AddressMock.getWards();
  }
}

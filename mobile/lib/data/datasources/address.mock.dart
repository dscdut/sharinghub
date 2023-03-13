import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

abstract class AddressMock {
  static Future<List<ProvinceModel>> getPronvinces() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      40,
      (index) => ProvinceModel(
        provinceName: 'Ha noi ${index.toString()}',
        provinceCode: index,
      ),
    );
  }

  static Future<List<DistrictModel>> getDistrict() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      40,
      (index) => DistrictModel(districtName: 'Ba Dinh', districtCode: index),
    );
  }

  static Future<List<WardModel>> getWards() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      40,
      (index) => WardModel(wardName: 'Thanh Xuan', wardCode: index),
    );
  }
}

import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

abstract class AddressMock {
  static List<ProvinceModel> getPronvinces() {
    return List.generate(
      40,
      (index) => ProvinceModel(
        provinceName: 'Ha noi ${index.toString()}',
        provinceCode: index,
      ),
    );
  }

  static List<DistrictModel> getDistrict() {
    return List.generate(
      40,
      (index) => DistrictModel(districtName: 'Ba Dinh', districtCode: index),
    );
  }

  static List<WardModel> getWards() {
    return List.generate(
      40,
      (index) => WardModel(wardName: 'Thanh Xuan', wardCode: index),
    );
  }
}

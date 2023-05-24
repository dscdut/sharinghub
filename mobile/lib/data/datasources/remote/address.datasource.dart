import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/models/address/district.model.dart';
import 'package:mobile/data/models/address/province.model.dart';
import 'package:mobile/data/models/address/ward.model.dart';

@lazySingleton
class AddressDataSource {
  final DioHelper _dioHelper;

  const AddressDataSource({required DioHelper dioHelper})
      : _dioHelper = dioHelper;

  Future<List<ProvinceModel>> getPronvinces() async {
    final response = await _dioHelper.get(
      Endpoints.province,
    );

    return response.body
        .map<ProvinceModel>((e) => ProvinceModel.fromJson(e))
        .toList();
  }

  Future<List<DistrictModel>> getDistricts(int provinceCode) async {
    final response = await _dioHelper.get(
      '${Endpoints.province}/$provinceCode',
      queryParameters: {
        'depth': 2,
      },
    );
    return response.body['districts']
        .map<DistrictModel>((e) => DistrictModel.fromJson(e))
        .toList();
  }

  Future<List<WardModel>> getWards(int districtCode) async {
    final response = await _dioHelper.get(
      '${Endpoints.district}/$districtCode',
      queryParameters: {
        'depth': 2,
      },
    );
    return response.body['wards']
        .map<WardModel>((e) => WardModel.fromJson(e))
        .toList();
  }
}

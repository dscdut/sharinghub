import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  final DioHelper _dioHelper;

  const CampaignDataSource({
    required DioHelper dioHelper,
  }) : _dioHelper = dioHelper;

  Future<List<CampaignModel>> getCampaigns() async {
    return CampaignMock.getCampains();
  }

  Future<List<CampaignModel>> searchCampaigns(
    int? provinceCode,
    int? districtCode,
    int? wardCode,
    String keyword,
  ) async {
    return await CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignById(int id) async {
    return (await CampaignMock.getCampains())[id];
  }

  Future<CampaignModel> setCampaign(SetCampaignDTO setCampaignParams) async {
    return await CampaignMock.setCampaign(setCampaignParams);
  }

  Future<List<CampaignModel>> getCampainsByLocation(LatLng wardLocation) async {
    final result = await _dioHelper.get(
      Endpoints.campaign,
      queryParameters: {
        'lat': '10.123456',
        'lng': '10.123456',
      }, //fake queryParams cause API get list lat lng not ready
    );
    return result.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return (await CampaignMock.getCampains())[0];
  }

  Future<void> joinCampaign(int campaignId) async {}
}

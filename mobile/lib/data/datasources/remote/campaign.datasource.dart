import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
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
    return CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return (await CampaignMock.getCampains())[0];
  }

  Future<void> joinCampaign(int campaignId) async {}
}

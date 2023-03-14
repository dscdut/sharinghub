import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  Future<List<CampaignModel>> getCampaigns() async {
    return CampaignMock.getCampaigns();
  }

  Future<List<CampaignModel>> searchCampaigns(
    int? provinceCode,
    int? districtCode,
    int? wardCode,
    String keyword,
  ) async {
    return await CampaignMock.getCampaigns();
  }

  Future<CampaignModel> getCampaignById(int id) async {
    return (await CampaignMock.getCampaigns())[id];
  }

  Future<CampaignModel> setCampaign(SetCampaignDTO setCampaignParams) async {
    return await CampaignMock.setCampaign(setCampaignParams);
  }

  Future<List<CampaignModel>> getCampaignsByLocation(
    LatLng wardLocation,
  ) async {
    return CampaignMock.getCampaigns();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return (await CampaignMock.getCampaigns())[0];
  }

  Future<void> joinCampaign(int campaignId) async {}

  Future<void> feedbackToCampaign(FeedbackToCampaignDTO params) async {}
}

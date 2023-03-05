import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  Future<List<CampaignModel>> getHomeProject() async {
    await Future.delayed(const Duration(seconds: 3));
    return CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignById(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    return CampaignMock.getCampains()[id];
  }

  Future<CampaignModel> setCampaign(SetCampaignDTO setCampaignParams) async {
    await Future.delayed(const Duration(seconds: 2));
    return CampaignMock.setCampaign(setCampaignParams);
  }

  Future<List<CampaignModel>> getCampainsByLocation(LatLng wardLocation) async {
    return CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return CampaignMock.getCampains()[0];
  }

  Future<void> joinCampaign(int campaignId) async {}
}

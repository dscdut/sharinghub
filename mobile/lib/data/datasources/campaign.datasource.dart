import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  Future<List<CampaignModel>> getHomeProject() async {
    await Future.delayed(const Duration(seconds: 3));
    return CampaignMock.getCampains();
  }

  Future<CampaignModel> setCampaign(CampaignModel params) async {
    return CampaignMock.setCampaign(params);
  }

  Future<List<CampaignModel>> getCampainsByLocation(LatLng wardLocation) async {
    return CampaignMock.getCampains();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return CampaignMock.getCampains()[0];
  }

  Future<void> joinCampaign(int campaignId) async {}
}

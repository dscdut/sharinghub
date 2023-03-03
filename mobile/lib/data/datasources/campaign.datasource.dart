import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
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

  Future<CampaignModel> setCampaign(CampaignModel params) async {
    await Future.delayed(const Duration(seconds: 3));
    return CampaignMock.setCampaign(params);
  }
}

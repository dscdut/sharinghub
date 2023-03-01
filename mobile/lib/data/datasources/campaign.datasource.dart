import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/campaign.mock.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  Future<CampaignModel> setCampaign(CampaignModel params) async {
    return CampaignMock.setCampaign(params);
  }
}

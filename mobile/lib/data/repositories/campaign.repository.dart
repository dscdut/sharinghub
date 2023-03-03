import 'package:mobile/data/datasources/campaign.datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignRepository {
  final CampaignDataSource _dataSource;

  CampaignRepository({required CampaignDataSource dataSource})
      : _dataSource = dataSource;

  Future<List<CampaignModel>> getHomeProject() {
    return _dataSource.getHomeProject();
  }

  Future<CampaignModel> getCampaignById(int id) async {
    return _dataSource.getCampaignById(id);
  }

  Future<CampaignModel> setCampaign(CampaignModel params) async {
    return _dataSource.setCampaign(params);
  }
}

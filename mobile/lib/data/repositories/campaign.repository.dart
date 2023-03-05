import 'package:mobile/data/datasources/campaign.datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignRepository {
  final CampaignDataSource _dataSource;

  CampaignRepository({required CampaignDataSource dataSource})
      : _dataSource = dataSource;

  Future<List<CampaignModel>> getCampaigns() {
    return _dataSource.getCampaigns();
  }

  Future<List<CampaignModel>> searchCampaigns(
    int? provinceCode,
    int? districtCode,
    int? wardCode,
    String keyword,
  ) {
    return _dataSource.searchCampaigns(
      provinceCode,
      districtCode,
      wardCode,
      keyword,
    );
  }

  Future<CampaignModel> setCampaign(CampaignModel params) {
    return _dataSource.setCampaign(params);
  }
}

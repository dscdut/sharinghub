import 'package:mobile/data/datasources/campaign.datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignRepository {
  final CampaignDataSource _dataSource;

  CampaignRepository({required CampaignDataSource dataSource})
      : _dataSource = dataSource;

  Future<CampaignModel> setCampaign(CampaignModel params) {
    return _dataSource.setCampaign(params);
  }
}

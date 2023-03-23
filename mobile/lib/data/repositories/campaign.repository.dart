import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/data/datasources/remote/campaign.datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
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

  Future<CampaignModel> getCampaignById(int id) async {
    return _dataSource.getCampaignById(id);
  }

  Future<void> setCampaign(SetCampaignDTO setCampaignParams) {
    log(setCampaignParams.toJson().toString());

    return _dataSource.setCampaign(setCampaignParams);
  }

  Future<List<CampaignModel>> getCampainsByLocation(LatLng wardLocation) async {
    return _dataSource.getCampainsByLocation(wardLocation);
  }

  Future<List<CampaignModel>> getCampaignsByOrganizationId(int organizationId) {
    return _dataSource.getCampaignsByOrganizationId(organizationId);
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    return _dataSource.getCampaignDetail(campaignId);
  }

  Future<void> joinCampaign(int campaignId) async {
    return _dataSource.joinCampaign(campaignId);
  }
}

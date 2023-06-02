import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/data/datasources/remote/campaign.datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/data/datasources/user.mock.dart';
import 'package:mobile/data/dtos/paticipant_feedback.dto.dart';
import 'package:mobile/data/dtos/organization_feedback.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/dtos/set_donate.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';
import 'package:mobile/data/models/user.model.dart';

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
    String? keyword,
  ) {
    return _dataSource.searchCampaigns(
      provinceCode,
      districtCode,
      wardCode,
      keyword,
    );
  }

  Future<void> setCampaign(SetCampaignDTO setCampaignParams) {
    return _dataSource.setCampaign(setCampaignParams);
  }

  Future<List<CampaignModel>> getCampaignsByLocation(
    LatLng wardLocation,
  ) async {
    return _dataSource.getCampaignsByLocation(wardLocation);
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

  Future<void> organizationFeedback(OrganizationFeedbackDTO params) async {
    return _dataSource.organizationFeedback(params);
  }

  Future<void> updateOrganizationFeedback(
      OrganizationFeedbackDTO params) async {
    return _dataSource.updateOrganizationFeedback(params);
  }

  Future<void> participantFeedback(ParticipantFeedbackDTO params) async {
    return _dataSource.participantFeedback(params);
  }

  Future<List<CampaignModel>> getMyVolunteer() async {
    return _dataSource.getListVoluntaryCampaign();
  }

  Future<void> donateToCampaign(SetDonateDTO params) async {
    return _dataSource.donateToCampaign(params);
  }
}

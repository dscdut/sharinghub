import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/campaign.model.dart';

@lazySingleton
class CampaignDataSource {
  final DioHelper _dioHelper;

  CampaignDataSource({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<List<CampaignModel>> getCampaigns() async {
    final response = await _dioHelper.get(
      Endpoints.campaigns,
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<List<CampaignModel>> searchCampaigns(
    int? provinceCode,
    int? districtCode,
    int? wardCode,
    String keyword,
  ) async {
    final response = await _dioHelper.get(
      Endpoints.campaigns,
      queryParameters: {
        'name': keyword,
      },
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<void> setCampaign(SetCampaignDTO setCampaignParams) async {
    await _dioHelper.post(
      '${Endpoints.campaignByOrganization}/${setCampaignParams.organizationId}/campaigns',
      formData: setCampaignParams.toJson(),
    );
  }

  Future<List<CampaignModel>> getCampaignsByLocation(
    LatLng wardLocation,
  ) async {
    final response = await _dioHelper.get(
      Endpoints.campaigns,
      queryParameters: {
        'lat': wardLocation.latitude,
        'lng': wardLocation.longitude,
      },
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<List<CampaignModel>> getCampaignsByOrganizationId(
    int organizationId,
  ) async {
    final response = await _dioHelper
        .get('${Endpoints.campaignByOrganization}/$organizationId/campaigns');

    return (response.body as List<dynamic>)
        .map((e) => CampaignModel.fromJson(e))
        .toList();
  }

  Future<CampaignModel> getCampaignDetail(int campaignId) async {
    final response = await _dioHelper.get(
      '${Endpoints.campaigns}/$campaignId',
    );
    return CampaignModel.fromJson(response.body);
  }

  Future<void> joinCampaign(int campaignId) async {}

  Future<void> feedbackToCampaign(FeedbackToCampaignDTO params) async {}
}

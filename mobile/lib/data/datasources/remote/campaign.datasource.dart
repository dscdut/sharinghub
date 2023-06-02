import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/common/constants/endpoints.dart';
import 'package:mobile/common/helpers/dio.helper.dart';
import 'package:mobile/data/dtos/paticipant_feedback.dto.dart';
import 'package:mobile/data/dtos/organization_feedback.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/dtos/set_donate.dto.dart';
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
    String? keyword,
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

  Future<void> joinCampaign(int campaignId) async {
    _dioHelper.post(
      '${Endpoints.campaigns}/$campaignId/volunteers',
    );
  }

  Future<void> organizationFeedback(OrganizationFeedbackDTO params) async {
    await _dioHelper.post(
      '${Endpoints.campaigns}/${params.campaignId}/feedbacks',
      formData: params.toJson(),
    );
  }

  Future<void> updateOrganizationFeedback(
    OrganizationFeedbackDTO params,
  ) async {
    await _dioHelper.put(
      '${Endpoints.campaigns}/${params.campaignId}/feedbacks',
      formData: params.toJson(),
    );
  }

  Future<void> participantFeedback(ParticipantFeedbackDTO params) async {
    //mock api
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> donateToCampaign(SetDonateDTO params) async {
    await _dioHelper.post(
      '${Endpoints.campaigns}/${params.campaignId}/donations',
      formData: params.toJson(),
    );
  }

  Future<List<CampaignModel>> getListVoluntaryCampaign() async {
    final response = await _dioHelper.get(
      Endpoints.myVoluntary,
    );
    return response.body
        .map<CampaignModel>((e) => CampaignModel.fromJson(e))
        .toList();
  }
}

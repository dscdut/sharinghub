// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_campaign.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackToCampaignDTO _$FeedbackToCampaignDTOFromJson(
        Map<String, dynamic> json) =>
    FeedbackToCampaignDTO(
      images: json['images'] as List<dynamic>?,
      locationRate: json['location_rate'] as int? ?? 0,
      traffic: json['traffic'] as String?,
      weather: json['weather'] as String?,
      sanitization: json['sanitization'] as String?,
      residence: json['residence'] as String?,
      authorityCooperation: json['authority_cooperation'] as String?,
      campaign: json['campaign'] == null
          ? null
          : CampaignModel.fromJson(json['campaign'] as Map<String, dynamic>),
      others: json['others'] as String?,
    );

Map<String, dynamic> _$FeedbackToCampaignDTOToJson(
        FeedbackToCampaignDTO instance) =>
    <String, dynamic>{
      'images': instance.images,
      'location_rate': instance.locationRate,
      'traffic': instance.traffic,
      'weather': instance.weather,
      'sanitization': instance.sanitization,
      'residence': instance.residence,
      'authority_cooperation': instance.authorityCooperation,
      'campaign': instance.campaign?.toJson(),
      'others': instance.others,
    };

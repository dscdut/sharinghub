// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) =>
    CampaignModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      address: json['address'] as String,
      specificAddress: json['specificAddress'] as String?,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      formLink: json['formLink'] as String?,
      artifactTypes: json['artifactTypes'] as String?,
      otherInformation: json['otherInformation'] as String?,
      imageURL: json['image'] as String?,
      geometry: (json['coordinate'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      orgName: json['organizationName'] as String,
    );

Map<String, dynamic> _$CampaignModelToJson(CampaignModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.imageURL,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'specificAddress': instance.specificAddress,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'formLink': instance.formLink,
      'artifactTypes': instance.artifactTypes,
      'otherInformation': instance.otherInformation,
      'coordinate': instance.geometry,
      'organizationName': instance.orgName,
    };

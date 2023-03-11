// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_campaign.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SetCampaignDTOToJson(SetCampaignDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.image);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('address', instance.address);
  writeNotNull('specific_address', instance.specificAddress);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('form_link', instance.formLink);
  writeNotNull('artifact_types', instance.artifactTypes);
  writeNotNull('other_information', instance.otherInformation);
  writeNotNull('geometry', instance.geometry);
  return val;
}

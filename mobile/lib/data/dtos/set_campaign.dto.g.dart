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

  writeNotNull('name', instance.name);
  writeNotNull('image', instance.image);
  writeNotNull('address', instance.address);
  writeNotNull('specificAddress', instance.specificAddress);
  writeNotNull('coordinate', instance.coordinate);
  writeNotNull('description', instance.description);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('registerLink', instance.registerLink);
  writeNotNull('donationRequirement', instance.donationRequirement);
  writeNotNull('otherInformation', instance.otherInformation);
  return val;
}

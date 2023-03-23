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
  writeNotNull('address', instance.address);
  writeNotNull('specific_address', instance.specificAddress);
  writeNotNull('coordinate', instance.coordinate);
  writeNotNull('description', instance.description);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('end_date', instance.endDate?.toIso8601String());
  writeNotNull('register_link', instance.registerLink);
  writeNotNull('donation_requirement', instance.donationRequirement);
  writeNotNull('other_information', instance.otherInformation);
  return val;
}

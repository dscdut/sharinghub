// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) =>
    CampaignModel(
      id: json['id'] as int?,
      organization: OrganizationModel.fromJson(
          json['organization'] as Map<String, dynamic>),
      name: json['name'] as String,
      address: json['address'] as String,
      specificAddress: json['specificAddress'] as String?,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      formLink: json['formLink'] as String?,
      artifactTypes: json['artifactTypes'] as String?,
      otherInformation: json['otherInformation'] as String?,
      imageURL: json['imageURL'] as String?,
      geometry: (json['geometry'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CampaignModelToJson(CampaignModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['imageURL'] = instance.imageURL;
  val['name'] = instance.name;
  val['description'] = instance.description;
  val['address'] = instance.address;
  val['specificAddress'] = instance.specificAddress;
  val['startDate'] = instance.startDate.toIso8601String();
  val['endDate'] = instance.endDate.toIso8601String();
  val['formLink'] = instance.formLink;
  val['artifactTypes'] = instance.artifactTypes;
  val['otherInformation'] = instance.otherInformation;
  val['geometry'] = instance.geometry;
  return val;
}

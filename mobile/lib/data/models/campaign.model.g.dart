// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignModel _$CampaignModelFromJson(Map<String, dynamic> json) =>
    CampaignModel(
      id: json['id'] as int?,
      organizationId:
          UserModel.fromJson(json['organizationId'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      registerLink: json['registerLink'] as String?,
      haveArtifactDonate: json['haveArtifactDonate'] as bool,
      artifactRequirement: json['artifactRequirement'] as String?,
      otherInfo: json['otherInfo'] as String?,
    );

Map<String, dynamic> _$CampaignModelToJson(CampaignModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['address'] = instance.address.toJson();
  val['startDate'] = instance.startDate.toIso8601String();
  val['endDate'] = instance.endDate.toIso8601String();
  val['description'] = instance.description;
  val['registerLink'] = instance.registerLink;
  val['organizationId'] = instance.organizationId.toJson();
  val['haveArtifactDonate'] = instance.haveArtifactDonate;
  val['artifactRequirement'] = instance.artifactRequirement;
  val['otherInfo'] = instance.otherInfo;
  return val;
}

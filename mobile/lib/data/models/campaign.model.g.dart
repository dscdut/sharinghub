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
      isUserJoined: json['joined'] as bool?,
      description: json['description'] as String?,
      startDate: const JsonSerializableDateTime()
          .fromJson(json['startDate'] as String),
      endDate:
          const JsonSerializableDateTime().fromJson(json['endDate'] as String),
      registerLink: json['registerLink'] as String?,
      donationRequirement: json['donationRequirement'] as String?,
      otherInformation: json['otherInformation'] as String?,
      image: json['image'] as String?,
      feedback: json['feedback'] == null
          ? null
          : FeedbackToCampaignDTO.fromJson(
              json['feedback'] as Map<String, dynamic>),
      coordinate: (json['coordinate'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      organizationName: json['organizationName'] as String?,
      organizationAvatar: json['organizationAvatar'] as String?,
      organizationId: json['organizationId'] as int?,
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
  val['image'] = instance.image;
  val['address'] = instance.address;
  val['specificAddress'] = instance.specificAddress;
  val['coordinate'] = instance.coordinate;
  val['description'] = instance.description;
  val['startDate'] =
      const JsonSerializableDateTime().toJson(instance.startDate);
  val['endDate'] = const JsonSerializableDateTime().toJson(instance.endDate);
  val['registerLink'] = instance.registerLink;
  val['donationRequirement'] = instance.donationRequirement;
  val['otherInformation'] = instance.otherInformation;
  val['organizationName'] = instance.organizationName;
  val['organizationAvatar'] = instance.organizationAvatar;
  val['organizationId'] = instance.organizationId;
  return val;
}

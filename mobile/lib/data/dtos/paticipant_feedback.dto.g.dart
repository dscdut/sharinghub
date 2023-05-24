// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paticipant_feedback.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantFeedbackDTO _$ParticipantFeedbackDTOFromJson(
        Map<String, dynamic> json) =>
    ParticipantFeedbackDTO(
      campaignRate: json['campaignRate'] as int? ?? 0,
      campaignReview: json['campaignReview'] as String?,
      organizationRate: json['organizationRate'] as int? ?? 0,
      organizationReview: json['organizationReview'] as String?,
      campaignId: json['campaignId'] as int?,
    );

Map<String, dynamic> _$ParticipantFeedbackDTOToJson(
    ParticipantFeedbackDTO instance) {
  final val = <String, dynamic>{
    'campaignRate': instance.campaignRate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('campaignReview', instance.campaignReview);
  val['organizationRate'] = instance.organizationRate;
  writeNotNull('organizationReview', instance.organizationReview);
  return val;
}

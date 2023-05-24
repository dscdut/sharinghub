import 'package:json_annotation/json_annotation.dart';

part 'paticipant_feedback.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class ParticipantFeedbackDTO {
  int campaignRate;
  String? campaignReview;
  int organizationRate;
  String? organizationReview;
  @JsonKey(includeToJson: false)
  int? campaignId;

  ParticipantFeedbackDTO({
    this.campaignRate = 0,
    this.campaignReview,
    this.organizationRate = 0,
    this.organizationReview,
    this.campaignId,
  });

  factory ParticipantFeedbackDTO.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFeedbackDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantFeedbackDTOToJson(this);

  ParticipantFeedbackDTO copyWith({
    int? campaignRate,
    String? campaignReview,
    int? organizationRate,
    String? organizationReview,
    int? campaignId,
  }) {
    return ParticipantFeedbackDTO(
      campaignRate: campaignRate ?? this.campaignRate,
      campaignReview: campaignReview ?? this.campaignReview,
      organizationRate: organizationRate ?? this.organizationRate,
      organizationReview: organizationReview ?? this.organizationReview,
      campaignId: campaignId ?? this.campaignId,
    );
  }
}

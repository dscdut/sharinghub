import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/models/user.model.dart';

part 'paticipant_feedback.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class ParticipantFeedbackDTO {
  int campaignRate;
  String? organizationFeedback;
  int organizationRate;
  String? campaignFeedback;
  @JsonKey(includeToJson: false)
  UserModel? user;
  @JsonKey(includeToJson: false)
  int? campaignId;

  ParticipantFeedbackDTO({
    this.campaignRate = 0,
    this.campaignFeedback,
    this.organizationRate = 0,
    this.organizationFeedback,
    this.user,
    this.campaignId,
  });

  factory ParticipantFeedbackDTO.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFeedbackDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantFeedbackDTOToJson(this);

  ParticipantFeedbackDTO copyWith({
    int? campaignRate,
    String? campaignFeedback,
    int? organizationRate,
    String? organizationFeedback,
    int? campaignId,
  }) {
    return ParticipantFeedbackDTO(
      campaignRate: campaignRate ?? this.campaignRate,
      campaignFeedback: campaignFeedback ?? this.campaignFeedback,
      organizationRate: organizationRate ?? this.organizationRate,
      organizationFeedback: organizationFeedback ?? this.organizationFeedback,
      campaignId: campaignId ?? this.campaignId,
    );
  }
}

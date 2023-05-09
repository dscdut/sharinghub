import 'package:json_annotation/json_annotation.dart';

part 'feedback_individual.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class FeedbackIndividualDTO {
  int campaignRate;
  String? campaignReview;
  int organizationRate;
  String? organizationReview;
  @JsonKey(includeToJson: false)
  int? campaignId;

  FeedbackIndividualDTO({
    this.campaignRate = 0,
    this.campaignReview,
    this.organizationRate = 0,
    this.organizationReview,
    this.campaignId,
  });

  factory FeedbackIndividualDTO.fromJson(Map<String, dynamic> json) =>
      _$FeedbackIndividualDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackIndividualDTOToJson(this);

  FeedbackIndividualDTO copyWith({
    int? campaignRate,
    String? campaignReview,
    int? organizationRate,
    String? organizationReview,
    int? campaignId,
  }) {
    return FeedbackIndividualDTO(
      campaignRate: campaignRate ?? this.campaignRate,
      campaignReview: campaignReview ?? this.campaignReview,
      organizationRate: organizationRate ?? this.organizationRate,
      organizationReview: organizationReview ?? this.organizationReview,
      campaignId: campaignId ?? this.campaignId,
    );
  }
}

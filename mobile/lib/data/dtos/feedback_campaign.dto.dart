import 'package:json_annotation/json_annotation.dart';

part 'feedback_campaign.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class FeedbackToCampaignDTO {
  @JsonKey(name: 'image')
  List<dynamic>? images;
  int locationRate;
  String? traffic;
  String? weather;
  String? sanitization;
  String? residence;
  String? authorityCooperation;
  String? others;
  @JsonKey(includeToJson: false)
  int? campaignId;

  FeedbackToCampaignDTO({
    this.images,
    this.locationRate = 0,
    this.traffic,
    this.weather,
    this.sanitization,
    this.residence,
    this.authorityCooperation,
    this.others,
    this.campaignId,
  });

  factory FeedbackToCampaignDTO.fromJson(Map<String, dynamic> json) =>
      _$FeedbackToCampaignDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackToCampaignDTOToJson(this);

  FeedbackToCampaignDTO copyWith({
    List<dynamic>? images,
    int? locationRate,
    String? traffic,
    String? weather,
    String? sanitization,
    String? residence,
    String? authorityCooperation,
    String? others,
    int? campaignId,
  }) {
    return FeedbackToCampaignDTO(
      images: images ?? this.images,
      locationRate: locationRate ?? this.locationRate,
      traffic: traffic ?? this.traffic,
      weather: weather ?? this.weather,
      sanitization: sanitization ?? this.sanitization,
      residence: residence ?? this.residence,
      authorityCooperation: authorityCooperation ?? this.authorityCooperation,
      others: others ?? this.others,
      campaignId: campaignId ?? this.campaignId,
    );
  }
}

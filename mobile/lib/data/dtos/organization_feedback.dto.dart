import 'package:json_annotation/json_annotation.dart';

part 'organization_feedback.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class OrganizationFeedbackDTO {
  @JsonKey(name: 'image')
  List<dynamic>? images;
  int locationRate;
  String? traffic;
  String? weather;
  String? sanitization;
  String? residence;
  String? authorityCooperation;
  @JsonKey(includeIfNull: false)
  String? others;
  @JsonKey(includeToJson: false)
  int? campaignId;

  OrganizationFeedbackDTO({
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

  factory OrganizationFeedbackDTO.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFeedbackDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationFeedbackDTOToJson(this);

  OrganizationFeedbackDTO copyWith({
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
    return OrganizationFeedbackDTO(
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

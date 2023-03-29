import 'package:json_annotation/json_annotation.dart';

part 'set_campaign.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
  explicitToJson: true,
)
class SetCampaignDTO {
  String? name;
  dynamic image;
  String? address;
  String? specificAddress;
  Map<String, double>? coordinate;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  @JsonKey(includeIfNull: false)
  String? registerLink;
  @JsonKey(includeIfNull: false)
  String? donationRequirement;
  @JsonKey(includeIfNull: false)
  String? otherInformation;
  @JsonKey(includeToJson: false)
  String? placeId;
  @JsonKey(includeToJson: false)
  int? organizationId;

  SetCampaignDTO({
    this.image,
    this.name,
    this.description,
    this.address,
    this.specificAddress,
    this.startDate,
    this.endDate,
    this.registerLink,
    this.donationRequirement,
    this.otherInformation,
    this.coordinate,
    this.placeId,
    this.organizationId,
  });

  Map<String, dynamic> toJson() => _$SetCampaignDTOToJson(this);

  SetCampaignDTO copyWith({
    String? name,
    dynamic image,
    String? address,
    String? specificAddress,
    Map<String, double>? coordinate,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? registerLink,
    String? donationRequirement,
    String? otherInformation,
    String? placeId,
    int? organizationId,
  }) {
    return SetCampaignDTO(
      name: name ?? this.name,
      image: image ?? this.image,
      address: address ?? this.address,
      specificAddress: specificAddress ?? this.specificAddress,
      coordinate: coordinate ?? this.coordinate,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registerLink: registerLink ?? this.registerLink,
      donationRequirement: donationRequirement ?? this.donationRequirement,
      otherInformation: otherInformation ?? this.otherInformation,
      placeId: placeId ?? this.placeId,
      organizationId: organizationId ?? this.organizationId,
    );
  }
}

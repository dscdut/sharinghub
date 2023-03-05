import 'package:json_annotation/json_annotation.dart';

part 'set_campaign.dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  createFactory: false,
  explicitToJson: false,
)
class SetCampaignDTO {
  dynamic image;
  String? name;
  String? description;
  String? address;
  String? specificAddress;
  DateTime? startDate;
  DateTime? endDate;
  String? formLink;
  String? artifactTypes;
  String? otherInformation;
  Map<String, double>? geometry;
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? placeId;

  SetCampaignDTO({
    this.image,
    this.name,
    this.description,
    this.address,
    this.specificAddress,
    this.startDate,
    this.endDate,
    this.formLink,
    this.artifactTypes,
    this.otherInformation,
    this.geometry,
    this.placeId,
  });

  Map<String, dynamic> toJson() => _$SetCampaignDTOToJson(this);

  SetCampaignDTO copyWith({
    dynamic image,
    String? name,
    String? description,
    String? address,
    String? specificAddress,
    DateTime? startDate,
    DateTime? endDate,
    String? formLink,
    String? artifactTypes,
    String? otherInformation,
    Map<String, double>? geometry,
    String? placeId,
  }) {
    return SetCampaignDTO(
      image: image ?? this.image,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      specificAddress: specificAddress ?? this.specificAddress,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      formLink: formLink ?? this.formLink,
      artifactTypes: artifactTypes ?? this.artifactTypes,
      otherInformation: otherInformation ?? this.otherInformation,
      geometry: geometry ?? this.geometry,
      placeId: placeId ?? this.placeId,
    );
  }
}

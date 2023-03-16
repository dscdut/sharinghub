import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';

import 'package:mobile/generated/locale_keys.g.dart';

part 'campaign.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CampaignModel {
  // @JsonKey(includeIfNull: false)
  final int? id;

  @JsonKey(name: 'image')
  final String? imageURL;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'specificAddress')
  final String? specificAddress;

  @JsonKey(name: 'startDate')
  final DateTime startDate;

  @JsonKey(name: 'endDate')
  final DateTime endDate;
  final String? formLink;
  final String? artifactTypes;
  final String? otherInformation;

  @JsonKey(name: 'coordinate')
  final Map<String, double> geometry;

  // @JsonKey(includeFromJson: true, includeToJson: false)
  // final OrganizationModel? organization;

  @JsonKey(name: 'organizationName')
  final String orgName;

  bool get isOngoing => DateTime.now().isBeforeOrEqualTo(endDate);

  String get statusContent => isOngoing
      ? LocaleKeys.campaign_ongoing.tr()
      : LocaleKeys.campaign_ended.tr();

  String get fullDate => '${startDate.toDisplay} - ${endDate.toDisplay}';

  CampaignModel({
    this.id,
    // required this.organization,
    required this.name,
    required this.address,
    this.specificAddress,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.formLink,
    this.artifactTypes,
    this.otherInformation,
    this.imageURL,
    required this.geometry,
    required this.orgName,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignModelFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignModelToJson(this);

  SetCampaignDTO toSetCampaignDTO() {
    return SetCampaignDTO(
      name: name,
      description: description,
      address: address,
      specificAddress: specificAddress,
      startDate: startDate,
      endDate: endDate,
      formLink: formLink,
      artifactTypes: artifactTypes,
      otherInformation: otherInformation,
      geometry: geometry,
      image: imageURL,
    );
  }
}

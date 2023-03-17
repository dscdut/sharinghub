import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/common/utils/json.util.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/organization.model.dart';

import 'package:mobile/generated/locale_keys.g.dart';

part 'campaign.model.g.dart';

@JsonSerializable(explicitToJson: true)
@JsonSerializableDateTime()
class CampaignModel {
  @JsonKey(includeIfNull: false)
  final int? id;
  final String name;
  final String? image;
  final String address;
  final String? specificAddress;
  final Map<String, double> coordinate;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String? registerLink;
  final String? donationRequirement;
  final String? otherInformation;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final OrganizationModel? organization;

  bool get isOngoing => DateTime.now().isBeforeOrEqualTo(endDate);

  String get statusContent => isOngoing
      ? LocaleKeys.campaign_ongoing.tr()
      : LocaleKeys.campaign_ended.tr();

  String get fullDate => '${startDate.toDisplay} - ${endDate.toDisplay}';

  CampaignModel({
    this.id,
    this.organization,
    required this.name,
    required this.address,
    this.specificAddress,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.registerLink,
    this.donationRequirement,
    this.otherInformation,
    this.image,
    required this.coordinate,
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
      registerLink: registerLink,
      donationRequirement: donationRequirement,
      otherInformation: otherInformation,
      coordinate: coordinate,
      image: image,
    );
  }
}

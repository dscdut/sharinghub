import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';
import 'package:mobile/data/models/organization.model.dart';

import 'package:mobile/generated/locale_keys.g.dart';

part 'campaign.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CampaignModel {
  @JsonKey(includeIfNull: false)
  final int? id;
  final String? imageURL;
  final String name;
  final String description;
  final String address;
  final String? specificAddress;
  final DateTime startDate;
  final DateTime endDate;
  final String? formLink;
  final String? artifactTypes;
  final String? otherInformation;
  final Map<String, double> geometry;
  final FeedbackToCampaignDTO? feedback;
  @JsonKey(includeFromJson: true, includeToJson: false)
  final OrganizationModel organization;

  bool get isOngoing => DateTime.now().isBeforeOrEqualTo(endDate);

  bool get isEnded => DateTime.now().isAfter(endDate);

  bool get hasFeedback => feedback != null;

  String get statusContent => isOngoing
      ? LocaleKeys.campaign_ongoing.tr()
      : LocaleKeys.campaign_ended.tr();

  String get fullDate => '${startDate.toDisplay} - ${endDate.toDisplay}';

  CampaignModel({
    this.id,
    required this.organization,
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
    this.feedback,
    required this.geometry,
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

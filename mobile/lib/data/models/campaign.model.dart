import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/data/models/address.model.dart';

import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'campaign.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CampaignModel {
  @JsonKey(includeIfNull: false)
  final int? id;
  final String name;
  final AddressModel address;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String? registerLink;
  @JsonKey(includeFromJson: true, includeToJson: false)
  final OrganizationModel organization;
  final bool haveArtifactDonate;
  final String? artifactRequirement;
  final String? otherInfo;
  final String? imageURL;

  bool get isOngoing => DateTime.now().isBeforeOrEqualTo(endDate);

  String get statusContent => isOngoing
      ? LocaleKeys.campaign_ongoing.tr()
      : LocaleKeys.campaign_ended.tr();

  String get fullDate => '${startDate.toDisplay} - ${endDate.toDisplay}';

  CampaignModel({
    this.id,
    required this.organization,
    required this.name,
    required this.description,
    required this.address,
    required this.startDate,
    required this.endDate,
    this.registerLink,
    required this.haveArtifactDonate,
    this.artifactRequirement,
    this.otherInfo,
    this.imageURL,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) =>
      _$CampaignModelFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignModelToJson(this);
}

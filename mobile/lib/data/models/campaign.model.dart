import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/models/address.model.dart';

import 'package:mobile/data/models/user.model.dart';

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
  final UserModel organization;
  final bool haveArtifactDonate;
  final String? artifactRequirement;
  final String? otherInfo;
  final String? imageURL;

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

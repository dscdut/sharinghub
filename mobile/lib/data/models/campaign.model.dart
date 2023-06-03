import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/extensions/date_time.extension.dart';
import 'package:mobile/common/utils/json.util.dart';
import 'package:mobile/data/dtos/feedback_campaign.dto.dart';
import 'package:mobile/data/dtos/set_campaign.dto.dart';

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
  final Map<String, double>? coordinate;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? registerLink;
  final String? donationRequirement;
  final String? otherInformation;
  @JsonKey(includeIfNull: false, includeToJson: false)
  final FeedbackToCampaignDTO? feedback;
  @JsonKey(name: 'joined', includeIfNull: false, includeToJson: false)
  final bool? isUserJoined;
  final String? organizationName;
  final String? organizationAvatar;
  final int? organizationId;

  bool get isUpcoming => startDate.isAfter(DateTime.now());
  bool get isOngoing =>
      startDate.isBefore(DateTime.now()) && endDate.isAfter(DateTime.now());
  bool get isEnded => endDate.isBefore(DateTime.now());

  bool get hasFeedback => feedback != null;

  String get statusContent => isUpcoming
      ? LocaleKeys.profile_upcoming.tr()
      : isOngoing
          ? LocaleKeys.campaign_ongoing.tr()
          : LocaleKeys.campaign_ended.tr();

  String get fullDate => '${startDate.toDisplay} - ${endDate.toDisplay}';

  CampaignModel({
    this.id,
    required this.name,
    required this.address,
    this.specificAddress,
    this.isUserJoined,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.registerLink,
    this.donationRequirement,
    this.otherInformation,
    this.image,
    this.feedback,
    this.coordinate,
    this.organizationName,
    this.organizationAvatar,
    this.organizationId,
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

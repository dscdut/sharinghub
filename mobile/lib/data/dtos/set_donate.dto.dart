import 'package:json_annotation/json_annotation.dart';

part 'set_donate.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
)
class SetDonateDTO {
  String? itemName;
  dynamic image;
  int? quantity;
  @JsonKey(includeToJson: false)
  int? campaignId;

  SetDonateDTO({
    this.image,
    this.itemName,
    this.quantity,
    this.campaignId,
  });

  Map<String, dynamic> toJson() => _$SetDonateDTOToJson(this);

  SetDonateDTO copyWith({
    String? itemName,
    dynamic image,
    int? quantity,
    int? campaignId,
  }) {
    return SetDonateDTO(
      itemName: itemName ?? this.itemName,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      campaignId: campaignId ?? this.campaignId,
    );
  }
}

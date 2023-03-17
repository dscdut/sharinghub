import 'package:json_annotation/json_annotation.dart';

part 'set_organization.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
)
class SetOrganizationDTO {
  final int? id;
  dynamic image;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? description;

  SetOrganizationDTO({
    this.id,
    this.image,
    this.name,
    this.phoneNumber,
    this.address,
    this.description,
  });

  Map<String, dynamic> toJson() => _$SetOrganizationDTOToJson(this);

  SetOrganizationDTO copyWith({
    int? id,
    dynamic avatar,
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    return SetOrganizationDTO(
      id: id ?? this.id,
      image: avatar ?? image,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'set_organization.dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
  createFactory: false,
)
class SetOrganizationDTO {
  final int? id;
  final String? avatar;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? description;

  SetOrganizationDTO({
    this.id,
    this.avatar,
    this.name,
    this.phoneNumber,
    this.address,
    this.description,
  });

  Map<String, dynamic> toJson() => _$SetOrganizationDTOToJson(this);

  SetOrganizationDTO copyWith({
    int? id,
    String? avatar,
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    return SetOrganizationDTO(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }
}

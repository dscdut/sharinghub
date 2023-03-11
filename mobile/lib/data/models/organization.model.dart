import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';

part 'organization.model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class OrganizationModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String address;
  final String? description;
  final String? avatar;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.description,
    this.avatar,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  SetOrganizationDTO toSetOrganizationDTO() {
    return SetOrganizationDTO(
      id: id,
      name: name,
      avatar: avatar,
      phoneNumber: phoneNumber,
      address: address,
      description: description,
    );
  }
}

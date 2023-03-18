import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/dtos/set_organization.dto.dart';

part 'organization.model.g.dart';

@JsonSerializable()
class OrganizationModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String address;
  final String description;
  final String? avatar;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.description,
    this.avatar,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);

  SetOrganizationDTO toSetOrganizationDTO() {
    return SetOrganizationDTO(
      id: id,
      name: name,
      image: avatar,
      phoneNumber: phoneNumber,
      address: address,
      description: description,
    );
  }
}

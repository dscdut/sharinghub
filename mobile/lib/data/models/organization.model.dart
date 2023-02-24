import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/data/models/user.model.dart';

part 'organization.model.g.dart';

@JsonSerializable(createToJson: false)
class OrganizationModel extends UserModel {
  final String organizationName;
  final String organizationCEO;

  OrganizationModel({
    required this.organizationName,
    required this.organizationCEO,
    required String email,
  }) : super(email: email);

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}

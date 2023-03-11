import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

abstract class BaseUserModel {
  final int id;
  final String name;
  final String? address;
  final String? avatar;
  final String email;
  final String? phoneNumber;

  BaseUserModel({
    required this.id,
    required this.name,
    this.address,
    this.avatar,
    required this.email,
    this.phoneNumber,
  });
}

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class OrganizationModel extends BaseUserModel {
  final String? description;
  final int? userId;
  final int organizationId;

  OrganizationModel({
    required this.organizationId,
    required super.name,
    super.address,
    super.avatar,
    required super.email,
    super.phoneNumber,
    this.description,
    this.userId,
  }) : super(id: organizationId);

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}

@JsonSerializable()
class UserModel extends BaseUserModel {
  final bool? gender;
  final DateTime? birthDay;

  UserModel({
    required super.id,
    required super.name,
    super.address,
    super.avatar,
    required super.email,
    super.phoneNumber,
    this.gender,
    this.birthDay,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserProfileModel extends BaseUserModel {
  final String? avatarURL;
  final int projectPending;
  final int projectCompleted;
  final int projectOnGoing;

  UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    this.avatarURL,
    required this.projectPending,
    required this.projectCompleted,
    required this.projectOnGoing,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

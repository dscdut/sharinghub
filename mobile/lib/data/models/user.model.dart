import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel {
  final int id;
  final String fullName;
  final String email;
  final DateTime? birthDay;
  final bool? gender;
  final String? phoneNumber;
  final String? address;
  final String? avatar;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.birthDay,
    this.gender,
    this.phoneNumber,
    this.address,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserProfileModel extends UserModel {
  final String? avatarURL;
  final int projectPending;
  final int projectCompleted;
  final int projectOnGoing;

  UserProfileModel({
    required super.id,
    required super.email,
    this.avatarURL,
    super.phoneNumber,
    super.address,
    super.birthDay,
    super.gender,
    required this.projectPending,
    required this.projectCompleted,
    required this.projectOnGoing,
    required super.fullName,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

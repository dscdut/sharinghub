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

  final int? projectPending;
  final int? projectCompleted;
  final int? projectOnGoing;
  final String? school;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.birthDay,
    this.gender,
    this.phoneNumber,
    this.address,
    this.avatar,
    this.projectPending,
    this.projectCompleted,
    this.projectOnGoing,
    this.school,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

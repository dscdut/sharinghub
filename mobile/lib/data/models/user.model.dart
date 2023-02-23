import 'package:json_annotation/json_annotation.dart';

part 'user.model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel {
  final String email;
  final String fullName;

  UserModel({
    required this.email,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

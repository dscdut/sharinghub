import 'package:json_annotation/json_annotation.dart';

import 'package:mobile/data/models/user.model.dart';

part 'personal.model.g.dart';

@JsonSerializable(createToJson: false)
class PersonalModel extends UserModel {
  final String fullName;

  PersonalModel({
    required this.fullName,
    required String email,
  }) : super(email: email);

  factory PersonalModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalModelFromJson(json);
}

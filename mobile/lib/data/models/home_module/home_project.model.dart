import 'package:json_annotation/json_annotation.dart';

part 'home_project.model.g.dart';

@JsonSerializable()
class HomeProjectModel {
  final String name;
  final String id;
  final String orgName;
  final String imageURL;

  const HomeProjectModel({
    required this.name,
    required this.id,
    required this.orgName,
    required this.imageURL,
  });

  factory HomeProjectModel.fromJson(Map<String, dynamic> json) =>
      _$HomeProjectModelFromJson(json);
}

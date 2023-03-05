import 'package:json_annotation/json_annotation.dart';

part 'place.model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlaceModel {
  final String description;
  final String placeId;
  final List<String> types;

  PlaceModel({
    required this.description,
    required this.placeId,
    required this.types,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}

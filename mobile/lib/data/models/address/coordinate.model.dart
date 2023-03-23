import 'package:json_annotation/json_annotation.dart';

part 'coordinate.model.g.dart';

@JsonSerializable()
class CoordinateModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'coordinate')
  final Coordinate coordinate;

  const CoordinateModel({
    required this.id,
    required this.name,
    required this.coordinate,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateModelFromJson(json);
}

@JsonSerializable()
class Coordinate {
  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'lng')
  final double lng;

  const Coordinate({
    required this.lat,
    required this.lng,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
}

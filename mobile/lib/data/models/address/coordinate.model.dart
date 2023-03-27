import 'package:json_annotation/json_annotation.dart';

part 'coordinate.model.g.dart';

@JsonSerializable()
class CoordinateModel {
  final int id;
  final String name;
  final Coordinate? coordinate;

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
  final double lat;

  final double lng;

  const Coordinate({
    required this.lat,
    required this.lng,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
}

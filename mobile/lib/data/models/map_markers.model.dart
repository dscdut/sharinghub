import 'package:json_annotation/json_annotation.dart';

part 'map_markers.model.g.dart';

@JsonSerializable()
class MapMarkersModel {
  final double lat;
  final double lng;
  final String id;

  const MapMarkersModel({
    required this.lat,
    required this.lng,
    required this.id,
  });
}

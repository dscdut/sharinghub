// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_marker.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapMarkerModel _$MapMarkerModelFromJson(Map<String, dynamic> json) =>
    MapMarkerModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$MapMarkerModelToJson(MapMarkerModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
    };

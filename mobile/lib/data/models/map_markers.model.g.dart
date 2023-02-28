// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_markers.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapMarkersModel _$MapMarkersModelFromJson(Map<String, dynamic> json) =>
    MapMarkersModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      id: json['id'] as String,
    );

Map<String, dynamic> _$MapMarkersModelToJson(MapMarkersModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'id': instance.id,
    };

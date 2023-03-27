// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateModel _$CoordinateModelFromJson(Map<String, dynamic> json) =>
    CoordinateModel(
      id: json['id'] as int,
      name: json['name'] as String,
      coordinate: json['coordinate'] == null
          ? null
          : Coordinate.fromJson(json['coordinate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoordinateModelToJson(CoordinateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coordinate': instance.coordinate,
    };

Coordinate _$CoordinateFromJson(Map<String, dynamic> json) => Coordinate(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordinateToJson(Coordinate instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

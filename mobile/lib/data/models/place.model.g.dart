// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

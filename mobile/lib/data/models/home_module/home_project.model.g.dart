// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_project.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeProjectModel _$HomeProjectModelFromJson(Map<String, dynamic> json) =>
    HomeProjectModel(
      name: json['name'] as String,
      id: json['id'] as String,
      orgName: json['orgName'] as String,
      imageURL: json['imageURL'] as String,
    );

Map<String, dynamic> _$HomeProjectModelToJson(HomeProjectModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'orgName': instance.orgName,
      'imageURL': instance.imageURL,
    };

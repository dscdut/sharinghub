// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      districtName: json['name'] as String,
      districtCode: json['code'] as int,
    );

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'name': instance.districtName,
      'code': instance.districtCode,
    };

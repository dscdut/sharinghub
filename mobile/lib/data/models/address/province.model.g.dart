// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      provinceName: json['name'] as String,
      provinceCode: json['code'] as int,
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'name': instance.provinceName,
      'code': instance.provinceCode,
    };

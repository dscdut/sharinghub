// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardModel _$WardModelFromJson(Map<String, dynamic> json) => WardModel(
      wardName: json['name'] as String,
      wardCode: json['code'] as int,
    );

Map<String, dynamic> _$WardModelToJson(WardModel instance) => <String, dynamic>{
      'name': instance.wardName,
      'code': instance.wardCode,
    };

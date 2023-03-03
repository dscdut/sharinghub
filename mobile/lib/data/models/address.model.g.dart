// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      province: json['province'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      specificAddress: json['specificAddress'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
      'specificAddress': instance.specificAddress,
    };

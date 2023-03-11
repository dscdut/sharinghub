// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    OrganizationModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
    );

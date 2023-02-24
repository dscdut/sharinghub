// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationDTOToJson(AuthenticationDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

Map<String, dynamic> _$PersonalRegisterDTOToJson(
        PersonalRegisterDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
    };

Map<String, dynamic> _$OrganizationRegisterDTOToJson(
        OrganizationRegisterDTO instance) =>
    <String, dynamic>{
      'organizationName': instance.organizationName,
      'organizationCEO': instance.organizationCEO,
      'email': instance.email,
      'password': instance.password,
    };

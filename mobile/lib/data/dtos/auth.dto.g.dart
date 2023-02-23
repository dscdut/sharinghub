// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthenticationDTOToJson(AuthenticationDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

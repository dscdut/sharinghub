// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'accessToken': instance.accessToken,
    };

Map<String, dynamic> _$SubmitLoginDTOToJson(SubmitLoginDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

Map<String, dynamic> _$SubmitRegisterDTOToJson(SubmitRegisterDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

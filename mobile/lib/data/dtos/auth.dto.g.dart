// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseDTO _$AuthResponseDTOFromJson(Map<String, dynamic> json) =>
    AuthResponseDTO(
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$AuthResponseDTOToJson(AuthResponseDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

Map<String, dynamic> _$SubmitLoginDTOToJson(SubmitLoginDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

Map<String, dynamic> _$SubmitRegisterDTOToJson(SubmitRegisterDTO instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('representativeName', instance.representativeName);
  val['email'] = instance.email;
  val['password'] = instance.password;
  return val;
}

AccessTokenDTO _$AccessTokenDTOFromJson(Map<String, dynamic> json) =>
    AccessTokenDTO(
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$AccessTokenDTOToJson(AccessTokenDTO instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
    };

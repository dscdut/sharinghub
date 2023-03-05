// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUserDTO _$BaseUserDTOFromJson(Map<String, dynamic> json) => BaseUserDTO(
      organizationId: json['organization_id'] as int?,
      userId: json['user_id'] as int?,
      fullName: json['full_name'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as bool?,
      birthDay: json['birth_day'] == null
          ? null
          : DateTime.parse(json['birth_day'] as String),
      avatar: json['avatar'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String,
      address: json['address'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BaseUserDTOToJson(BaseUserDTO instance) =>
    <String, dynamic>{
      'organization_id': instance.organizationId,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'name': instance.name,
      'gender': instance.gender,
      'birth_day': instance.birthDay?.toIso8601String(),
      'avatar': instance.avatar,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      'description': instance.description,
    };

AuthResponseDTO _$AuthResponseDTOFromJson(Map<String, dynamic> json) =>
    AuthResponseDTO(
      user: BaseUserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseDTOToJson(AuthResponseDTO instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
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

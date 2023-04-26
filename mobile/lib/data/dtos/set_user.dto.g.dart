// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SetUserDTOToJson(SetUserDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('birthDate', instance.birthDate?.toIso8601String());
  writeNotNull('gender', instance.gender);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('address', instance.address);
  writeNotNull('workplace', instance.workplace);
  return val;
}

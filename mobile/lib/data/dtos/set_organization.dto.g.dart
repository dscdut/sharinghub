// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_organization.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SetOrganizationDTOToJson(SetOrganizationDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('name', instance.name);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  return val;
}

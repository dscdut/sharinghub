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
  writeNotNull('image', instance.image);
  writeNotNull('name', instance.name);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  return val;
}

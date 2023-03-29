// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_donate.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SetDonateDTOToJson(SetDonateDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('itemName', instance.itemName);
  writeNotNull('image', instance.image);
  writeNotNull('quantity', instance.quantity);
  return val;
}

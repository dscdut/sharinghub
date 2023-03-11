// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      birthDay: json['birth_day'] == null
          ? null
          : DateTime.parse(json['birth_day'] as String),
      gender: json['gender'] as bool?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'birth_day': instance.birthDay?.toIso8601String(),
      'gender': instance.gender,
      'phone_number': instance.phoneNumber,
      'address': instance.address,
      'avatar': instance.avatar,
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as int,
      email: json['email'] as String,
      avatarURL: json['avatarURL'] as String?,
      projectPending: json['projectPending'] as int,
      projectCompleted: json['projectCompleted'] as int,
      projectOnGoing: json['projectOnGoing'] as int,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'projectPending': instance.projectPending,
      'projectCompleted': instance.projectCompleted,
      'projectOnGoing': instance.projectOnGoing,
    };

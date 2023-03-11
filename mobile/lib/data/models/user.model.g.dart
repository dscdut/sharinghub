// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    OrganizationModel(
      organizationId: json['organization_id'] as int,
      name: json['name'] as String,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      description: json['description'] as String?,
      userId: json['user_id'] as int?,
    );

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as bool?,
      birthDay: json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'avatar': instance.avatar,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'birthDay': instance.birthDay?.toIso8601String(),
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarURL: json['avatarURL'] as String?,
      projectPending: json['projectPending'] as int,
      projectCompleted: json['projectCompleted'] as int,
      projectOnGoing: json['projectOnGoing'] as int,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'projectPending': instance.projectPending,
      'projectCompleted': instance.projectCompleted,
      'projectOnGoing': instance.projectOnGoing,
    };

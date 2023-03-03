import 'package:mobile/data/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class BaseUserDTO {
  final int? organizationId;
  final int? userId;
  final String? fullName;
  final String? name;
  final bool? gender;
  final DateTime? birthDay;
  final String? avatar;
  final String? phoneNumber;
  final String email;
  final String? address;
  final String? description;

  BaseUserDTO({
    this.organizationId,
    this.userId,
    this.fullName,
    this.name,
    this.gender,
    this.birthDay,
    this.avatar,
    this.phoneNumber,
    required this.email,
    this.address,
    this.description,
  });

  UserModel toUser() {
    return UserModel(
      id: userId!,
      name: fullName!,
      address: address,
      avatar: avatar,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      birthDay: birthDay,
    );
  }

  OrganizationModel toOrganization() {
    return OrganizationModel(
      organizationId: organizationId!,
      name: name!,
      address: address,
      avatar: avatar,
      email: email,
      phoneNumber: phoneNumber,
      description: description,
      userId: userId,
    );
  }

  BaseUserModel toModel() {
    return organizationId == null ? toUser() : toOrganization();
  }

  factory BaseUserDTO.fromJson(Map<String, dynamic> json) =>
      _$BaseUserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUserDTOToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
)
class AuthResponseDTO {
  final BaseUserDTO user;
  // final String accessToken;
  // final String refreshToken;
  // final String expiresIn;

  AuthResponseDTO({
    required this.user,
    // required this.accessToken,
    // required this.refreshToken,
    // required this.expiresIn,
  });

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseDTOToJson(this);
}

@JsonSerializable(createFactory: false)
class SubmitLoginDTO {
  final String email;
  final String password;

  SubmitLoginDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SubmitLoginDTOToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class SubmitRegisterDTO {
  final String name;
  final String? representativeName;
  final String email;
  final String password;

  SubmitRegisterDTO({
    required this.name,
    this.representativeName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SubmitRegisterDTOToJson(this);
}

// @JsonSerializable()
// class RefreshTokenDTO {
//   final String accessToken;
//   final String refreshToken;
//   final String expiresIn;

//   RefreshTokenDTO({
//     required this.accessToken,
//     required this.refreshToken,
//     required this.expiresIn,
//   });

//   factory RefreshTokenDTO.fromJson(Map<String, dynamic> json) =>
//       _$RefreshTokenDTOFromJson(json);

//   Map<String, dynamic> toJson() => _$RefreshTokenDTOToJson(this);

//   Map<String, String> toLocalJson() {
//     return {
//       HiveKeys.accessToken: accessToken,
//       HiveKeys.refreshToken: refreshToken,
//       HiveKeys.expiresIn: expiresIn,
//     };
//   }
// }

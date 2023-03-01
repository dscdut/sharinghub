import 'package:mobile/data/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class AuthResponseDTO {
  final UserModel user;
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
class LoginDTO {
  final String email;
  final String password;

  LoginDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class RegisterDTO {
  final String name;
  final String? representativeName;
  final String email;
  final String password;

  RegisterDTO({
    required this.name,
    this.representativeName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);
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

import 'package:mobile/data/models/user.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDTO {
  // final UserModel user;
  final String email;
  final String password;
  // final String accessToken;
  // final String refreshToken;
  // final String expiresIn;

  LoginResponseDTO({
    // required this.user,
    required this.email,
    required this.password,
    // required this.accessToken,
    // required this.refreshToken,
    // required this.expiresIn,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);
}

@JsonSerializable(createFactory: false)
class AuthenticationDTO {
  final String email;
  final String password;

  AuthenticationDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$AuthenticationDTOToJson(this);
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

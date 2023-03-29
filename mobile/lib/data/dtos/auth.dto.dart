import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/models/user.model.dart';

part 'auth.dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class LoginResponseDTO {
  final UserModel user;
  final String accessToken;
  // final String refreshToken;
  // final String expiresIn;

  LoginResponseDTO({
    required this.user,
    required this.accessToken,
    // required this.refreshToken,
    // required this.expiresIn,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
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
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  SubmitRegisterDTO({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$SubmitRegisterDTOToJson(this);
}

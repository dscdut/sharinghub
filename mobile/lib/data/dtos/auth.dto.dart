import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/constants/hive_keys.dart';

part 'auth.dto.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class AuthResponseDTO {
  // final UserModel user;
  @JsonKey(name: 'accessToken')
  final String accessToken;
  // final String refreshToken;
  // final String expiresIn;

  AuthResponseDTO({
    // required this.user,
    required this.accessToken,
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

@JsonSerializable()
class AccessTokenDTO {
  final String accessToken;

  AccessTokenDTO({
    required this.accessToken,
  });

  factory AccessTokenDTO.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenDTOToJson(this);

  Map<String, String> toLocalJson() {
    return {
      HiveKeys.accessToken: accessToken,
    };
  }
}

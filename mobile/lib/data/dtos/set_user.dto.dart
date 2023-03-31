import 'package:json_annotation/json_annotation.dart';

part 'set_user.dto.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
)
class SetUserDTO {
  final int? id;
  final String? email;
  dynamic avatar;
  final String? fullName;
  final DateTime? birthDate;
  final bool? gender;
  final String? phoneNumber;
  final String? address;
  final String? workplace;

  SetUserDTO({
    this.id,
    this.avatar,
    this.email,
    this.fullName,
    this.birthDate,
    this.gender,
    this.phoneNumber,
    this.address,
    this.workplace,
  });

  Map<String, dynamic> toJson() => _$SetUserDTOToJson(this);

  SetUserDTO copyWith({
    int? id,
    dynamic avatar,
    String? fullName,
    String? email,
    DateTime? birthDate,
    bool? gender,
    String? phoneNumber,
    String? address,
    String? workplace,
  }) {
    return SetUserDTO(
      id: id ?? this.id,
      email: email ?? this.email,
      avatar: avatar ?? avatar,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      workplace: workplace ?? this.workplace,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/common/utils/wrapped_value.dart';

import 'package:mobile/data/models/organization.model.dart';

part 'user.model.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class UserModel extends Equatable {
  final int id;
  final String? avatar;
  final String fullName;
  final String? phoneNumber;
  final bool? gender;
  final String email;
  final DateTime? birthDay;
  final String? address;
  final String? workSpace;

  final int? projectPending;
  final int? projectCompleted;
  final int? projectOnGoing;
  @JsonKey(includeIfNull: true)
  final OrganizationModel? currentOrganization;

  bool get isOrganizationMode => currentOrganization != null;

  const UserModel({
    required this.id,
    this.avatar,
    required this.fullName,
    this.phoneNumber,
    this.gender,
    required this.email,
    this.birthDay,
    this.address,
    this.workSpace,
    this.projectPending,
    this.projectCompleted,
    this.projectOnGoing,
    this.currentOrganization,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        avatar,
        fullName,
        phoneNumber,
        gender,
        email,
        birthDay,
        address,
        workSpace
      ];

  UserModel copyWith({
    int? id,
    String? avatar,
    String? fullName,
    String? phoneNumber,
    bool? gender,
    String? email,
    DateTime? birthDay,
    String? address,
    String? workSpace,
    int? projectPending,
    int? projectCompleted,
    int? projectOnGoing,
    Wrapped<OrganizationModel?>? currentOrganization,
  }) {
    return UserModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      birthDay: birthDay ?? this.birthDay,
      address: address ?? this.address,
      workSpace: workSpace ?? this.workSpace,
      projectPending: projectPending ?? this.projectPending,
      projectCompleted: projectCompleted ?? this.projectCompleted,
      projectOnGoing: projectOnGoing ?? this.projectOnGoing,
      currentOrganization: currentOrganization == null
          ? this.currentOrganization
          : currentOrganization.value,
    );
  }
}

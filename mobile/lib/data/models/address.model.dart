import 'package:json_annotation/json_annotation.dart';

part 'address.model.g.dart';

@JsonSerializable()
class AddressModel {
  final String province;
  final String district;
  final String ward;
  final String specificAddress;

  AddressModel({
    required this.province,
    required this.district,
    required this.ward,
    required this.specificAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'district.model.g.dart';

@JsonSerializable()
class DistrictModel {
  @JsonKey(name: 'name')
  final String districtName;
  @JsonKey(name: 'code')
  final int districtCode;

  const DistrictModel({
    required this.districtName,
    required this.districtCode,
  });

  factory DistrictModel.all() => DistrictModel(
        districtName: LocaleKeys.search_all.tr(),
        districtCode: 0,
      );

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}

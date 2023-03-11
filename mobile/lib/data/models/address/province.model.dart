import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'province.model.g.dart';

@JsonSerializable()
class ProvinceModel {
  @JsonKey(name: 'name')
  final String provinceName;
  @JsonKey(name: 'code')
  final int provinceCode;

  bool get isPlaceHolder => provinceCode == 0;

  const ProvinceModel({
    required this.provinceName,
    required this.provinceCode,
  });

  factory ProvinceModel.all() => ProvinceModel(
        provinceName: LocaleKeys.search_all.tr(),
        provinceCode: 0,
      );

  factory ProvinceModel.fromJson(Map<String, dynamic> json) =>
      _$ProvinceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceModelToJson(this);
}

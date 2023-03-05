import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/generated/locale_keys.g.dart';

part 'ward.model.g.dart';

@JsonSerializable()
class WardModel {
  final String wardName;
  final int wardCode;

  const WardModel({
    required this.wardName,
    required this.wardCode,
  });

  factory WardModel.all() => WardModel(
        wardName: LocaleKeys.search_all.tr(),
        wardCode: 0,
      );

  factory WardModel.fromJson(Map<String, dynamic> json) =>
      _$WardModelFromJson(json);

  Map<String, dynamic> toJson() => _$WardModelToJson(this);
}

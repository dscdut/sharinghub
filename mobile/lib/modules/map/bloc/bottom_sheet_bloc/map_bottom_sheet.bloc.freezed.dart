// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_bottom_sheet.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MapBottomSheetState {
  HandleStatus get status => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<CampaignModel> get campaigns => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MapBottomSheetStateCopyWith<MapBottomSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapBottomSheetStateCopyWith<$Res> {
  factory $MapBottomSheetStateCopyWith(
          MapBottomSheetState value, $Res Function(MapBottomSheetState) then) =
      _$MapBottomSheetStateCopyWithImpl<$Res, MapBottomSheetState>;
  @useResult
  $Res call(
      {HandleStatus status, String? error, List<CampaignModel> campaigns});
}

/// @nodoc
class _$MapBottomSheetStateCopyWithImpl<$Res, $Val extends MapBottomSheetState>
    implements $MapBottomSheetStateCopyWith<$Res> {
  _$MapBottomSheetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? campaigns = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HandleStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      campaigns: null == campaigns
          ? _value.campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<CampaignModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MapBottomSheetStateCopyWith<$Res>
    implements $MapBottomSheetStateCopyWith<$Res> {
  factory _$$_MapBottomSheetStateCopyWith(_$_MapBottomSheetState value,
          $Res Function(_$_MapBottomSheetState) then) =
      __$$_MapBottomSheetStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HandleStatus status, String? error, List<CampaignModel> campaigns});
}

/// @nodoc
class __$$_MapBottomSheetStateCopyWithImpl<$Res>
    extends _$MapBottomSheetStateCopyWithImpl<$Res, _$_MapBottomSheetState>
    implements _$$_MapBottomSheetStateCopyWith<$Res> {
  __$$_MapBottomSheetStateCopyWithImpl(_$_MapBottomSheetState _value,
      $Res Function(_$_MapBottomSheetState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? error = freezed,
    Object? campaigns = null,
  }) {
    return _then(_$_MapBottomSheetState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HandleStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      campaigns: null == campaigns
          ? _value._campaigns
          : campaigns // ignore: cast_nullable_to_non_nullable
              as List<CampaignModel>,
    ));
  }
}

/// @nodoc

class _$_MapBottomSheetState extends _MapBottomSheetState {
  _$_MapBottomSheetState(
      {required this.status,
      this.error,
      required final List<CampaignModel> campaigns})
      : _campaigns = campaigns,
        super._();

  @override
  final HandleStatus status;
  @override
  final String? error;
  final List<CampaignModel> _campaigns;
  @override
  List<CampaignModel> get campaigns {
    if (_campaigns is EqualUnmodifiableListView) return _campaigns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_campaigns);
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MapBottomSheetStateCopyWith<_$_MapBottomSheetState> get copyWith =>
      __$$_MapBottomSheetStateCopyWithImpl<_$_MapBottomSheetState>(
          this, _$identity);
}

abstract class _MapBottomSheetState extends MapBottomSheetState {
  factory _MapBottomSheetState(
      {required final HandleStatus status,
      final String? error,
      required final List<CampaignModel> campaigns}) = _$_MapBottomSheetState;
  _MapBottomSheetState._() : super._();

  @override
  HandleStatus get status;
  @override
  String? get error;
  @override
  List<CampaignModel> get campaigns;
  @override
  @JsonKey(ignore: true)
  _$$_MapBottomSheetStateCopyWith<_$_MapBottomSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DataPoint _$DataPointFromJson(Map<String, dynamic> json) {
  return _DataPoint.fromJson(json);
}

/// @nodoc
mixin _$DataPoint {
  @PositionConverter()
  Position? get positionData => throw _privateConstructorUsedError;
  bool get dataReset => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataPointCopyWith<DataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataPointCopyWith<$Res> {
  factory $DataPointCopyWith(DataPoint value, $Res Function(DataPoint) then) =
      _$DataPointCopyWithImpl<$Res, DataPoint>;
  @useResult
  $Res call({@PositionConverter() Position? positionData, bool dataReset});
}

/// @nodoc
class _$DataPointCopyWithImpl<$Res, $Val extends DataPoint>
    implements $DataPointCopyWith<$Res> {
  _$DataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positionData = freezed,
    Object? dataReset = null,
  }) {
    return _then(_value.copyWith(
      positionData: freezed == positionData
          ? _value.positionData
          : positionData // ignore: cast_nullable_to_non_nullable
              as Position?,
      dataReset: null == dataReset
          ? _value.dataReset
          : dataReset // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataPointCopyWith<$Res> implements $DataPointCopyWith<$Res> {
  factory _$$_DataPointCopyWith(
          _$_DataPoint value, $Res Function(_$_DataPoint) then) =
      __$$_DataPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@PositionConverter() Position? positionData, bool dataReset});
}

/// @nodoc
class __$$_DataPointCopyWithImpl<$Res>
    extends _$DataPointCopyWithImpl<$Res, _$_DataPoint>
    implements _$$_DataPointCopyWith<$Res> {
  __$$_DataPointCopyWithImpl(
      _$_DataPoint _value, $Res Function(_$_DataPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? positionData = freezed,
    Object? dataReset = null,
  }) {
    return _then(_$_DataPoint(
      positionData: freezed == positionData
          ? _value.positionData
          : positionData // ignore: cast_nullable_to_non_nullable
              as Position?,
      dataReset: null == dataReset
          ? _value.dataReset
          : dataReset // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DataPoint extends _DataPoint {
  const _$_DataPoint(
      {@PositionConverter() required this.positionData, this.dataReset = false})
      : super._();

  factory _$_DataPoint.fromJson(Map<String, dynamic> json) =>
      _$$_DataPointFromJson(json);

  @override
  @PositionConverter()
  final Position? positionData;
  @override
  @JsonKey()
  final bool dataReset;

  @override
  String toString() {
    return 'DataPoint(positionData: $positionData, dataReset: $dataReset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataPoint &&
            (identical(other.positionData, positionData) ||
                other.positionData == positionData) &&
            (identical(other.dataReset, dataReset) ||
                other.dataReset == dataReset));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, positionData, dataReset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataPointCopyWith<_$_DataPoint> get copyWith =>
      __$$_DataPointCopyWithImpl<_$_DataPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataPointToJson(
      this,
    );
  }
}

abstract class _DataPoint extends DataPoint {
  const factory _DataPoint(
      {@PositionConverter() required final Position? positionData,
      final bool dataReset}) = _$_DataPoint;
  const _DataPoint._() : super._();

  factory _DataPoint.fromJson(Map<String, dynamic> json) =
      _$_DataPoint.fromJson;

  @override
  @PositionConverter()
  Position? get positionData;
  @override
  bool get dataReset;
  @override
  @JsonKey(ignore: true)
  _$$_DataPointCopyWith<_$_DataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

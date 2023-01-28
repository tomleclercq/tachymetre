// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DataPoint _$$_DataPointFromJson(Map<String, dynamic> json) => _$_DataPoint(
      positionData: _$JsonConverterFromJson<String, Position>(
          json['positionData'], const PositionConverter().fromJson),
      dataReset: json['dataReset'] as bool? ?? false,
    );

Map<String, dynamic> _$$_DataPointToJson(_$_DataPoint instance) =>
    <String, dynamic>{
      'positionData': _$JsonConverterToJson<String, Position>(
          instance.positionData, const PositionConverter().toJson),
      'dataReset': instance.dataReset,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

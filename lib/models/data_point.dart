///FREEZED CLASS > flutter pub run build_runner build -d
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'data_point.freezed.dart';
part 'data_point.g.dart';

@freezed
class DataPoint with _$DataPoint {
  const DataPoint._();
  const factory DataPoint({
    @PositionConverter() required Position? positionData,
    @Default(false) bool dataReset,
  }) = _DataPoint;

  factory DataPoint.fromJson(Map<String, Object?> json) =>
      _$DataPointFromJson(json);
}

class PositionConverter extends JsonConverter<Position, String> {
  const PositionConverter();

  @override
  Position fromJson(String json) {
    final object = jsonDecode(json);
    return Position(
      longitude: object['longitude'],
      latitude: object['latitude'],
      timestamp: object['timestamp'],
      accuracy: object['accuracy'],
      altitude: object['altitude'],
      heading: object['heading'],
      speed: object['speed'],
      speedAccuracy: object['speedAccuracy'],
    );
  }

  @override
  String toJson(Position object) {
    return jsonEncode({
      'longitude': object.longitude,
      'latitude': object.latitude,
      'timestamp': object.timestamp,
      'accuracy': object.accuracy,
      'altitude': object.altitude,
      'heading': object.heading,
      'speed': object.speed,
      'speedAccuracy': object.speedAccuracy,
    });
  }
}

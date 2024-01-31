import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final double latitude;
  final double longitude;
  final DateTime? timestamp; // When is the data acquired

  Position(
      {required this.latitude,
      required this.longitude,
      required this.timestamp});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

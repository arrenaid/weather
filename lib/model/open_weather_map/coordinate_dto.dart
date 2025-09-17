import 'package:json_annotation/json_annotation.dart';

part 'coordinate_dto.g.dart';

@JsonSerializable()
class CoordinateDTO {
  final double? lon;
  final double? lat;

  CoordinateDTO({this.lon, this.lat});

  factory CoordinateDTO.fromJson(Map<String, dynamic> json) =>
      _$CoordinateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateDTOToJson(this);
}

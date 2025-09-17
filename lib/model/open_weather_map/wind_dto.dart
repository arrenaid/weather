import 'package:json_annotation/json_annotation.dart';
part 'wind_dto.g.dart';

@JsonSerializable()
class WindDTO {
  final double? speed; //": 4.09,
  final double? deg; //": 121,
  final double? gust; //": 3.47

  WindDTO({this.speed, this.deg, this.gust});

  factory WindDTO.fromJson(Map<String, dynamic> json) =>
      _$WindDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WindDTOToJson(this);
}
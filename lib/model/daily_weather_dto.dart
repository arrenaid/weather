import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_dto.g.dart';

@JsonSerializable()
class DailyWeatherDTO {
  final String icon; //	"c02d"
  final double code; //	801
  final String description; //	"Few clouds"

  DailyWeatherDTO(
      {required this.icon, required this.code, required this.description});

  factory DailyWeatherDTO.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherDTOToJson(this);
}

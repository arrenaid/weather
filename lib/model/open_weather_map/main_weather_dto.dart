import 'package:json_annotation/json_annotation.dart';
part 'main_weather_dto.g.dart';

@JsonSerializable()
class MainWeatherDTO {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  MainWeatherDTO({this.id, this.main, this.description, this.icon});

  factory MainWeatherDTO.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MainWeatherDTOToJson(this);
}
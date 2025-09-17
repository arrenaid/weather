import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/open_weather_map/clouds_dto.dart';
import 'package:weather/model/open_weather_map/forecast/day_night_dto.dart';
import 'package:weather/model/open_weather_map/main_temp_dto.dart';
import 'package:weather/model/open_weather_map/rain_dto.dart';
import 'package:weather/model/open_weather_map/wind_dto.dart';
import '../main_weather_dto.dart';
part 'forecast_dto.g.dart';

@JsonSerializable()
class ForecastDTO {
  final double? dt; //": 1661857200,
  final MainTempDTO? main;
  final List<MainWeatherDTO>? weather;
  final CloudsDTO? clouds;
  final WindDTO? wind;
  final double? visibility;
  final double? pop; //": 0.84,
  final RainDTO? rain;
  final RainDTO? snow;
  final DayNightDTO? sys;
  @JsonKey(name: 'dt_txt')
  final String? date;

  ForecastDTO({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.snow,
    this.visibility,
    this.wind,
    this.sys,
    this.date
  });

  factory ForecastDTO.fromJson(Map<String, dynamic> json) =>
      _$ForecastDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDTOToJson(this);
}

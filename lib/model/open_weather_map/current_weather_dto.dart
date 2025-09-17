import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/open_weather_map/rain_dto.dart';
import 'package:weather/model/open_weather_map/sys_dto.dart';
import 'package:weather/model/open_weather_map/wind_dto.dart';
import 'clouds_dto.dart';
import 'coordinate_dto.dart';
import 'main_temp_dto.dart';
import 'main_weather_dto.dart';

part 'current_weather_dto.g.dart';

@JsonSerializable()
class CurrentWeatherDTO {
  // {
  // "coord": {
  // "lon": 7.367,
  // "lat": 45.133
  // },
  final CoordinateDTO? coord;
  final List<MainWeatherDTO>? weather;
  final String? base; // "base": "stations",
  // "main": {
  // "temp": 284.2,
  // "feels_like": 282.93,
  // "temp_min": 283.06,
  // "temp_max": 286.82,
  // "pressure": 1021,
  // "humidity": 60,
  // "sea_level": 1021,
  // "grnd_level": 910
  // },
  final MainTempDTO? main;
  final double? visibility; //"visibility": 10000,
  // "wind": {
  // "speed": 4.09,
  // "deg": 121,
  // "gust": 3.47
  // },
  final WindDTO? wind;

  // "rain": {
  // "1h": 2.73
  // },
  final RainDTO? rain;
  final RainDTO? snow;

  // "clouds": {
  // "all": 83
  // },
  final CloudsDTO? clouds;

  // "dt": 1726660758,
  final double? dt;

  // "sys": {
  // "type": 1,
  // "id": 6736,
  // "country": "IT",
  // "sunrise": 1726636384,
  // "sunset": 1726680975
  // },
  final SysDTO? sys;

  // "timezone": 7200,
  final double? timezone;

  // "id": 3165523,
  final int? id;

  // "name": "Province of Turin",
  final String? name;

  // "cod":200
  final double? cod;

  CurrentWeatherDTO({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.snow,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeatherDTO.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherDTOToJson(this);
}







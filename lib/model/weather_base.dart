import 'package:weather/model/weather.dart';

class WeatherBase implements Weather {
  late final double temp;
  late final double feels;
  late final double min;
  late final double max;

  late final double humidity;
  late final double pressure;

  late final List<WeatherBase>? weeklyForecast;
  late final double? vision;

  ///sun
  late final String? sunRise;
  late final String? sunSet;
  late final double? uvIndex;
  late final double? angleElevationSun;
  late final double? angleSunAzimuth;

  ///moon
  late final String? moonRise;
  late final String? moonSet;
  late final String? moonPhase;

  ///snow
  late final double? snow;
  late final double? snowDepth;

  late final int clouds;
  late final double? chanceOfPrecipitation;
  late final double? precipitation;
  late final double? dewPoint;
  late final double? ozone;

  late final double wind;
  late final double? windDirection;
  late final String? windDirShort;
  late final String? windDirFull;
  late final double? airQualityIndex;
  late final double? windGusts;

  late final String? stateCode;
  late final String? timeZone;
  late final String? timeResponse;
  late final String date;
  late final String city;
  late final String main;
  late final String icon;

  WeatherBase({
    required this.temp,
    required this.feels,
    required this.min,
    required this.max,
    required this.humidity,
    required this.pressure,
    this.weeklyForecast,
    this.vision,
    this.sunRise,
    this.sunSet,
    this.uvIndex,
    this.angleElevationSun,
    this.angleSunAzimuth,
    this.moonRise,
    this.moonSet,
    this.moonPhase,
    this.snow,
    this.snowDepth,
    required this.clouds,
    this.chanceOfPrecipitation,
    this.precipitation,
    this.dewPoint,
    this.ozone,
    required this.wind,
    this.windDirection,
    this.windDirShort,
    this.windDirFull,
    this.airQualityIndex,
    this.windGusts,
    this.stateCode,
    this.timeZone,
    this.timeResponse,
    required this.date,
    required this.city,
    required this.main,
    required this.icon,
  });

  WeatherBase.allRec({
    required this.temp,
    required this.feels,
    required this.min,
    required this.max,
    required this.humidity,
    required this.pressure,
    required this.weeklyForecast,
    required this.vision,
    required this.sunRise,
    required this.sunSet,
    required this.uvIndex,
    required this.angleElevationSun,
    required this.angleSunAzimuth,
    required this.moonRise,
    required this.moonSet,
    required this.moonPhase,
    required this.snow,
    required this.snowDepth,
    required this.clouds,
    required this.chanceOfPrecipitation,
    required this.precipitation,
    required this.dewPoint,
    required this.ozone,
    required this.wind,
    required this.windDirection,
    required this.windDirShort,
    required this.windDirFull,
    required this.airQualityIndex,
    required this.windGusts,
    required this.stateCode,
    required this.timeZone,
    required this.timeResponse,
    required this.date,
    required this.city,
    required this.main,
    required this.icon,
  });
}

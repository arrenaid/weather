import 'package:weather/model/weather.dart';

class WeatherBase implements Weather {
  late final String city;
  late final String main;
  late final String icon;
  late final double temp;
  late final double feels;
  late final double min;
  late final double max;
  late final double wind;
  late final double humidity;
  late final double pressure;
  late final int clouds;
  late final String date;
  late final List<WeatherBase>? weeklyForecast;
  late final double? vision;
  late final String? sunRise;
  late final String? sunSet;
  late final String? moonRise;
  late final String? moonSet;
  late final String? moonPhase;
  late final double? chanceOfPrecipitation;




  WeatherBase({
    required this.city,
    required this.main,
    required this.icon,
    required this.temp,
    required this.feels,
    required this.min,
    required this.max,
    required this.wind,
    required this.humidity,
    required this.pressure,
    required this.clouds,
    required this.date,
    this.weeklyForecast,
    this.vision,
    this.sunRise,
    this.sunSet,
    this.moonPhase,
    this.moonRise,
    this.moonSet,
    this.chanceOfPrecipitation
  });

  WeatherBase.week(
      {required this.city,
      required this.main,
      required this.icon,
      required this.temp,
      required this.feels,
      required this.min,
      required this.max,
      required this.wind,
      required this.humidity,
      required this.pressure,
      required this.clouds,
      required this.date,
      this.vision,
      required this.weeklyForecast});
}

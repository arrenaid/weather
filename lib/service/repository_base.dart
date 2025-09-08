import 'package:weather/model/weather_base.dart';

abstract class RepositoryBase{
  Future<WeatherBase?> getCurrentWeather(String city);
  Future<List<WeatherBase>?> getForecast(String city);
  Future<void> setApiKey();
}
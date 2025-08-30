import 'package:weather/model/weather_base.dart';

extension WeatherBaseUnit on WeatherBase {
  WeatherBase toUnit(List<WeatherBase> forecast) {
    return WeatherBase(
      city: city,
      main: main,
      icon: icon,
      temp: temp,
      feels: feels,
      min: forecast.first.min,
      max: forecast.first.max,
      wind: wind,
      humidity: humidity,
      pressure: pressure,
      clouds: clouds,
      date: date,
      vision: vision,
      weeklyForecast: forecast,
    );
  }
}
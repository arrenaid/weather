import 'package:weather/constants.dart';
import 'package:weather/model/daily_response_dto.dart';
import 'package:weather/model/weather_base.dart';

extension DailyResponseDtoToDomain on DailyResponseDTO {
  List<WeatherBase> toDomain() {
    List<WeatherBase> forecast = [];
    for (var e in data) {
      forecast.add(WeatherBase(
          city: city,
          main: e.weather.description,
          icon: e.weather.icon,
          temp: e.temp,
          feels: e.lowTemp,
          min: e.minTemp,
          max: e.maxTemp,
          wind: e.windDir,
          humidity: e.rh,
          pressure: convertHpaToMRS(e.pres),
          clouds: e.clouds.toInt(),
          date: e.datetime,
          vision: e.vis
      ));
    }
    return forecast;
  }
}

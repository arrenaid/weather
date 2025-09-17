import 'package:weather/model/open_weather_map/forecast/forecast_response_dto.dart';
import 'package:weather/model/weather_base.dart';

import '../../../utils.dart';

extension ForecastResponseDtoToDomain on ForecastResponseDTO {
  List<WeatherBase> toDomain() {
    List<WeatherBase> forecast = [];
    for (var e in list!) {
      forecast.add(WeatherBase.allRec(
          temperature: e.main?.temp ?? -100,
          feelsTemp: e.main?.feelsLike ?? -100,
          minTemp: e.main?.tempMin ?? -100,
          maxTemp: e.main?.tempMax ?? 11,
          humidity: e.main?.humidity ?? -100,
          pressure: e.main?.pressure ?? -100,
          weeklyForecast: null,
          vision: e.visibility,
          sunRise: getLocalTimeInUtcOnTimezone(city.sunrise, city.timezone),
          sunSet: getLocalTimeInUtcOnTimezone(city.sunset, city.timezone),
          uvIndex: null,
          angleElevationSun: null,
          angleHorlySun: null,
          moonRise: null,
          moonSet: null,
          moonPhase: null,
          snow: e.snow?.threeHour,
          snowDepth: null,
          cloudiness: e.clouds?.all ?? -100,
          chanceOfPrecipitation: e.pop,
          precipitation: e.rain?.threeHour,
          dewPoint: null,
          ozone: null,
          windSpeed: e.wind?.speed ?? -100,
          windDirection: e.wind?.deg,
          windDirShort: null,
          windDirFull: null,
          airQualityIndex: null,
          windGusts: e.wind?.gust,
          stateCode: null,
          timeZone: city.timezone.toString(),
          timeResponse: DateTime.now().toString(),
          date: e.date! /*!= null?  getTimeTimestamp(e.dt!):  DateTime.now().toString()*/,
          city: city.name ?? 'empty',
          description: e.weather!.first.description ?? '1',
          iconName: e.weather!.first.icon ?? ''));
    }
    return forecast;
  }
}

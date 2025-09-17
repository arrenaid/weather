import 'package:weather/model/open_weather_map/current_weather_dto.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/utils.dart';

extension CurrentWeatherDtoToDomain on CurrentWeatherDTO{
  WeatherBase toDomain() {
    return WeatherBase.allRec(
        temperature: main?.temp ?? -100,
        feelsTemp: main?.feelsLike ?? -100,
        minTemp: main?.tempMin ?? -100,
        maxTemp: main?.tempMax ?? -100,
        humidity: main?.humidity ?? -100,
        pressure: main?.pressure != null? convertHpaToMRS(main!.pressure!) : -100 ,
        weeklyForecast: null,
        vision: visibility != null? visibility!/1000 : null,
        sunRise:getLocalTimeInUtcOnTimezone(sys?.sunrise, timezone),
        sunSet: getLocalTimeInUtcOnTimezone(sys?.sunset, timezone),
        uvIndex: null,
        angleElevationSun: null,
        angleHorlySun: null,
        moonRise: null,
        moonSet: null,
        moonPhase: null,
        snow: snow?.oneHour,
        snowDepth: null,
        cloudiness: clouds?.all ?? -100,
        chanceOfPrecipitation: null,
        precipitation: rain?.oneHour,
        dewPoint: null,
        ozone: null,
        windSpeed: wind?.speed ?? -100,
        windDirection: wind?.deg,
        windDirShort: null,
        windDirFull: null,
        airQualityIndex: null,
        windGusts: wind?.gust,
        stateCode: sys?.country,
        timeZone: timezone.toString(),
        timeResponse:  DateTime.now().toString(),
        date: dt != null?  getTimeTimestamp(dt!):  DateTime.now().toString(),
        city: name ?? 'empty',
        description: weather?.first.description ?? 'empty',
        iconName: weather?.first.icon ?? '');
  }
}
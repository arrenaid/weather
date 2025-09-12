import '../../utils.dart';
import '../weather_base.dart';
import 'daily_response_dto.dart';

extension DailyResponseDtoToDomain on DailyResponseDTO {
  List<WeatherBase> toDomain() {
    List<WeatherBase> forecast = [];
    for (var e in data!) {
      forecast.add(WeatherBase.allRec(
        city: city!,
        description: e.weather!.description,
        iconName: e.weather!.icon,
        temperature: e.temp!,
        feelsTemp: e.lowTemp!,
        minTemp: e.minTemp!,
        maxTemp: e.maxTemp!,
        windSpeed: e.windDir!,
        humidity: e.rh!,
        pressure: convertHpaToMRS(e.pres!),
        cloudiness: e.clouds!,
        date: e.datetime!,
        vision: e.vis,
        sunRise: e.sunRiseTs != null ? getTimeTimestamp(e.sunRiseTs!) : null,
        sunSet: e.sunSetTs != null ? getTimeTimestamp(e.sunSetTs!) : null,
        uvIndex: e.uv,
        angleElevationSun: null,
        angleHorlySun: null,
        moonRise: e.moonRiseTs != null ? getTimeTimestamp(e.moonRiseTs!) : null,
        moonSet: e.moonSetTs != null ? getTimeTimestamp(e.moonSetTs!) : null,
        moonPhase: e.moonPhase!,
        snow: e.snow,
        snowDepth: e.snowDepth,
        chanceOfPrecipitation: e.pop,
        precipitation: e.precip,
        dewPoint: e.dewpt,
        ozone: e.ozone,
        windDirection: e.windDir,
        windDirShort: e.windCdir,
        windDirFull: e.windCdirFull,
        airQualityIndex: null,
        windGusts: e.windGustSpd,
        stateCode: stateCode,
        timeZone: timezone,
        timeResponse: e.datetime,
        weeklyForecast: null,
      ));
    }
    return forecast;
  }
}

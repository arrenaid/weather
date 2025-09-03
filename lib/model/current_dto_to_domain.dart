import 'package:weather/model/current_dto.dart';
import 'package:weather/model/weather_base.dart';
import '../constants.dart';

extension DailyResponseDtoToDomain on CurrentDTO {
  WeatherBase toDomain() {
    return WeatherBase(
      city: city,
      main: weather.description,
      icon: weather.icon,
      temp: temp,
      feels: appTemp,
      min: temp,
      max: temp,
      wind: wind,
      humidity: rh,
      pressure: convertHpaToMRS(pres),
      clouds: clouds.toInt(),
      date: datetime,
      vision: vis,
      sunRise: sunrise,
      sunSet: sunset,
      uvIndex: uv,
      snow: snow,
      precipitation: precip,
      dewPoint: dewpt,
      windDirection: windDir,
      windDirFull: windCDirFull,
      stateCode: stateCode,
      timeZone: timezone,
      timeResponse: time,
      airQualityIndex: aqi,
      windGusts: gust,
      angleElevationSun: elevAngle,
      angleSunAzimuth: hAngle,
      windDirShort: windCDir
    );
  }
}

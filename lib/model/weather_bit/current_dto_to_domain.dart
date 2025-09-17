import 'package:weather/model/weather_bit/current_dto.dart';
import 'package:weather/model/weather_base.dart';
import '../../utils.dart';

extension DailyResponseDtoToDomain on CurrentDTO {
  WeatherBase toDomain() {
    return WeatherBase(
      city: city!,
      description: weather!.description,
      iconName: weather!.icon,
      temperature: temp!,
      feelsTemp: appTemp!,
      minTemp: temp!,
      maxTemp: temp!,
      windSpeed: wind!,
      humidity: rh!,
      pressure: convertHpaToMRS(pres!),
      cloudiness: clouds!,
      date: datetime!,
      vision: vis,
      sunRise: sunrise != null ? getLocalTime(time: sunrise!, zone: timezone!) : null,
      sunSet: sunset != null ? getLocalTime(time: sunset!, zone: timezone!) : null,
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
      angleHorlySun: hAngle,
      windDirShort: windCDir
    );
  }
}

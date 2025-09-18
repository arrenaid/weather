import 'package:weather/model/weather_base.dart';

extension WeatherBaseUnit on WeatherBase {
  WeatherBase toUnit(List<WeatherBase> forecast) {
    return WeatherBase.allRec(
      city: city,
      description: description,
      iconName: iconName,
      temperature: temperature,
      feelsTemp: feelsTemp,
      minTemp: forecast.first.minTemp,
      maxTemp: forecast.first.maxTemp,
      windSpeed: windSpeed,
      humidity: humidity,
      pressure: pressure,
      cloudiness: cloudiness,
      date: date,
      vision: vision,
      weeklyForecast: forecast,
      moonPhase: forecast.first.moonPhase,
      moonRise:  forecast.first.moonRise,
      moonSet:  forecast.first.moonSet,
      chanceOfPrecipitation: forecast.first.chanceOfPrecipitation,
      snowDepth: forecast.first.snowDepth,
      sunRise: sunRise ?? forecast.first.sunRise,
      sunSet: sunSet ?? forecast.first.sunSet,
      uvIndex: uvIndex,
      angleElevationSun: angleElevationSun,
      angleHourlySun: angleHourlySun,
      snow: snow,
      precipitation: precipitation,
      dewPoint: dewPoint ?? forecast.first.dewPoint,
      windDirection: windDirection,
      windDirShort: windDirShort,
      windDirFull: windDirFull,
      airQualityIndex: airQualityIndex ?? forecast.first.airQualityIndex,
      windGusts: windGusts ?? forecast.first.windGusts,
      stateCode: stateCode,
      timeZone: timeZone,
      timeResponse: timeResponse,
      ozone: ozone ?? forecast.first.ozone,
    );
  }
}
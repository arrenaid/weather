import 'package:weather/model/weather_base.dart';

extension WeatherBaseUnit on WeatherBase {
  WeatherBase toUnit(List<WeatherBase> forecast) {
    return WeatherBase.allRec(
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
      moonPhase: forecast.first.moonPhase,
      moonRise:  forecast.first.moonRise,
      moonSet:  forecast.first.moonSet,
      chanceOfPrecipitation: forecast.first.chanceOfPrecipitation,
      snowDepth: forecast.first.snowDepth,
      sunRise: sunRise ?? forecast.first.sunRise,
      sunSet: sunSet,
      uvIndex: uvIndex,
      angleElevationSun: angleElevationSun,
      angleSunAzimuth: angleSunAzimuth,
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
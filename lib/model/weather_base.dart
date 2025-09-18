class WeatherBase{
  late final double temperature;
  late final double feelsTemp;
  late final double minTemp;
  late final double maxTemp;
  late final double humidity;
  late final double pressure;
  late final double? vision;

  ///sun
  late final String? sunRise;
  late final String? sunSet;
  late final double? uvIndex;
  late final double? angleElevationSun;
  late final double? angleHourlySun;

  ///moon
  late final String? moonRise;
  late final String? moonSet;
  late final double? moonPhase;

  ///snow
  late final double? snow;
  late final double? snowDepth;

  ///air
  late final double cloudiness;
  late final double? chanceOfPrecipitation;
  late final double? precipitation;
  late final double? dewPoint;
  late final double? ozone;
  late final double? airQualityIndex;

  ///wind
  late final double windSpeed;
  late final double? windDirection;
  late final String? windDirShort;
  late final String? windDirFull;
  late final double? windGusts;

  late final String? stateCode;
  late final String? timeZone;
  late final String? timeResponse;
  late final String date;

  late final String city;
  late final String description;
  late final String iconName;

  late final List<WeatherBase>? weeklyForecast;

  WeatherBase({
    required this.temperature,
    required this.feelsTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    this.weeklyForecast,
    this.vision,
    this.sunRise,
    this.sunSet,
    this.uvIndex,
    this.angleElevationSun,
    this.angleHourlySun,
    this.moonRise,
    this.moonSet,
    this.moonPhase,
    this.snow,
    this.snowDepth,
    required this.cloudiness,
    this.chanceOfPrecipitation,
    this.precipitation,
    this.dewPoint,
    this.ozone,
    required this.windSpeed,
    this.windDirection,
    this.windDirShort,
    this.windDirFull,
    this.airQualityIndex,
    this.windGusts,
    this.stateCode,
    this.timeZone,
    this.timeResponse,
    required this.date,
    required this.city,
    required this.description,
    required this.iconName,
  });

  WeatherBase.allRec({
    required this.temperature,
    required this.feelsTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    required this.weeklyForecast,
    required this.vision,
    required this.sunRise,
    required this.sunSet,
    required this.uvIndex,
    required this.angleElevationSun,
    required this.angleHourlySun,
    required this.moonRise,
    required this.moonSet,
    required this.moonPhase,
    required this.snow,
    required this.snowDepth,
    required this.cloudiness,
    required this.chanceOfPrecipitation,
    required this.precipitation,
    required this.dewPoint,
    required this.ozone,
    required this.windSpeed,
    required this.windDirection,
    required this.windDirShort,
    required this.windDirFull,
    required this.airQualityIndex,
    required this.windGusts,
    required this.stateCode,
    required this.timeZone,
    required this.timeResponse,
    required this.date,
    required this.city,
    required this.description,
    required this.iconName,
  });
}

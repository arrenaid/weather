import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/daily_weather_dto.dart';

part 'daily_data_dto.g.dart';

@JsonSerializable()
class DailyDataDTO {
  @JsonKey(name: 'app_max_temp')
  final double appMaxTemp;///Максимальная ощущаемая температура: 4°C //	17.3
  @JsonKey(name: 'app_min_temp')
  final double appMinTemp; ///Минимальная ощущаемая температура: -2°C //	11.5
  final double clouds; ///Облачность: 100%//	73
  @JsonKey(name: 'clouds_hi')
  final double cloudsHi; //	53
  @JsonKey(name: 'clouds_low')
  final double cloudsLow; //	30
  @JsonKey(name: 'clouds_mid')
  final double cloudsMid; //	81
  final String datetime; //	"2025-08-29"
  final double dewpt; ///Точка росы: 1°C //	11.6
  @JsonKey(name: 'high_temp')
  final double highTemp; //	17.3
  @JsonKey(name: 'low_temp')
  final double lowTemp; //	15.5
  @JsonKey(name: 'max_dhi', defaultValue: 0)
  final double? maxDhi; ///Максимальный индекс солнечного излучения: 655 //	null
  @JsonKey(name: 'max_temp')
  final double maxTemp; ///Максимальная температура: 1.5°C//	17.3
  @JsonKey(name: 'min_temp')
  final double minTemp; ///Минимальная температура: -1.23°C//	11.5
  @JsonKey(name: 'moon_phase')
  final double moonPhase; ///Фаза луны: 0.87//	0.45
  @JsonKey(name: 'moon_phase_lunation')
  final double moonPhaseLunation; //	0.23
  @JsonKey(name: 'moonrise_ts')
  final double moonRiseTs; ///Время восхода и заката солнца/луны: Указаны в формате timestamp //	1756461867
  @JsonKey(name: 'moonset_ts')
  final double moonSetTs; ///Время восхода и заката солнца/луны: Указаны в формате timestamp  //	1756489529
  final double ozone; //	304
  final double pop; ///Вероятность осадков: 75% //	75
  final double precip; ///Осадки: 1.1 мм //	5.3691406
  final double pres;///Атмосферное давление: 1005 гПа //	999
  final double rh;///Влажность: 95% //	86
  final double slp; ///Давление на уровне моря: 1012.89 гПа //	1017
  final double snow; ///Снег: 10.45 мм
  @JsonKey(name: 'snow_depth')
  final double snowDepth; ///Высота снежного покрова: 45 мм
  @JsonKey(name: 'sunrise_ts')
  final double sunRiseTs; ///Время восхода и заката солнца/луны: Указаны в формате timestamp  //	1756434371
  @JsonKey(name: 'sunset_ts')
  final double sunSetTs; ///Время восхода и заката солнца/луны: Указаны в формате timestamp //	1756484865
  final double temp; /// Температура: 1°C //	13.9
  final double ts; ///Локальное время Timestamp
  final double uv; ///УФ-индекс: 6.5 //	2
  @JsonKey(name: 'valid_date')
  final String validDate; //	"2025-08-29"
  final double vis; ///Видимость: 3 км //	23.6
  final DailyWeatherDTO
      weather; //	{ icon: "r01d", code: 500, description: "Light rain" }
  @JsonKey(name: 'wind_cdir')
  final String windCdir; ///Направление ветра: 105° (восток-северо-восток, wind_cdir: "ENE")//	"SSE"
  @JsonKey(name: 'wind_cdir_full')
  final String windCdirFull;///Направление ветра: 105° (восток-северо-восток, wind_cdir: "ENE") //	"south-southeast"
  @JsonKey(name: 'wind_dir')
  final double windDir; ///Направление ветра: 105°//	162
  @JsonKey(name: 'wind_gust_spd')
  final double windGustSpd; //	3.6
  @JsonKey(name: 'wind_spd')
  final double windSpd; ///Скорость ветра: 13.85 м/с

  DailyDataDTO(
      {required this.appMaxTemp,
      required this.appMinTemp,
      required this.clouds,
      required this.cloudsHi,
      required this.cloudsLow,
      required this.cloudsMid,
      required this.datetime,
      required this.dewpt,
      required this.highTemp,
      required this.lowTemp,
      required this.maxDhi,
      required this.maxTemp,
      required this.minTemp,
      required this.moonPhase,
      required this.moonPhaseLunation,
      required this.moonRiseTs,
      required this.moonSetTs,
      required this.ozone,
      required this.pop,
      required this.precip,
      required this.pres,
      required this.rh,
      required this.slp,
      required this.snow,
      required this.snowDepth,
      required this.sunRiseTs,
      required this.sunSetTs,
      required this.temp,
      required this.ts,
      required this.uv,
      required this.validDate,
      required this.vis,
      required this.weather,
      required this.windCdir,
      required this.windCdirFull,
      required this.windDir,
      required this.windGustSpd,
      required this.windSpd});

  factory DailyDataDTO.fromJson(Map<String, dynamic> json) =>
      _$DailyDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DailyDataDTOToJson(this);
}

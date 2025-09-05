import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/daily_weather_dto.dart';

part 'daily_data_dto.g.dart';

@JsonSerializable()
class DailyDataDTO {
  ///Максимальная ощущаемая температура: 4°C //	17.3
  @JsonKey(name: 'app_max_temp')
  final double? appMaxTemp;

  ///Минимальная ощущаемая температура: -2°C //	11.5
  @JsonKey(name: 'app_min_temp')
  final double? appMinTemp;

  ///Облачность: 100%//	73
  final double? clouds;

  @JsonKey(name: 'clouds_hi')
  final double? cloudsHi; //	53
  @JsonKey(name: 'clouds_low')
  final double? cloudsLow; //	30
  @JsonKey(name: 'clouds_mid')
  final double? cloudsMid; //	81
  final String? datetime; //	"2025-08-29"
  ///Точка росы: 1°C //	11.6
  final double? dewpt;
  @JsonKey(name: 'high_temp')
  final double? highTemp; //	17.3
  @JsonKey(name: 'low_temp')
  final double? lowTemp; //	15.5

  ///Максимальный индекс солнечного излучения: 655 //	null
  @JsonKey(name: 'max_dhi', defaultValue: 0)
  final double? maxDhi;

  ///Максимальная температура: 1.5°C//	17.3
  @JsonKey(name: 'max_temp')
  final double? maxTemp;

  ///Минимальная температура: -1.23°C//	11.5
  @JsonKey(name: 'min_temp')
  final double? minTemp;

  ///Фаза луны: 0.87//	0.45
  @JsonKey(name: 'moon_phase')
  final double? moonPhase;
  @JsonKey(name: 'moon_phase_lunation')
  final double? moonPhaseLunation; //	0.23

  ///Время восхода и заката солнца/луны: Указаны в формате timestamp //	1756461867
  @JsonKey(name: 'moonrise_ts')
  final double? moonRiseTs;

  ///Время восхода и заката солнца/луны: Указаны в формате timestamp  //	1756489529
  @JsonKey(name: 'moonset_ts')
  final double? moonSetTs;
  final double? ozone; //	304

  ///Вероятность осадков: 75% //	75
  final double? pop;

  ///Осадки: 1.1 мм //	5.3691406
  final double? precip;

  ///Атмосферное давление: 1005 гПа //	999
  final double? pres;

  ///Влажность: 95% //	86
  final double? rh;

  ///Давление на уровне моря: 1012.89 гПа //	1017
  final double? slp;

  ///Снег: 10.45 мм
  final double? snow;

  ///Высота снежного покрова: 45 мм
  @JsonKey(name: 'snow_depth')
  final double? snowDepth;

  ///Время восхода и заката солнца/луны: Указаны в формате timestamp  //	1756434371
  @JsonKey(name: 'sunrise_ts')
  final double? sunRiseTs;

  ///Время восхода и заката солнца/луны: Указаны в формате timestamp //	1756484865
  @JsonKey(name: 'sunset_ts')
  final double? sunSetTs;

  /// Температура: 1°C //	13.9
  final double? temp;

  ///Локальное время Timestamp
  final double? ts;

  ///УФ-индекс: 6.5 //	2
  final double? uv;
  @JsonKey(name: 'valid_date')
  final String? validDate; //	"2025-08-29"

  ///Видимость: 3 км //	23.6
  final double? vis;

//	{ icon: "r01d", code: 500, description: "Light rain" }
  final DailyWeatherDTO? weather;

  ///Направление ветра: 105° (восток-северо-восток, wind_cdir: "ENE")//	"SSE"
  @JsonKey(name: 'wind_cdir')
  final String? windCdir;

  ///Направление ветра: 105° (восток-северо-восток, wind_cdir: "ENE") //	"south-southeast"
  @JsonKey(name: 'wind_cdir_full')
  final String? windCdirFull;

  ///Направление ветра: 105°//	162
  @JsonKey(name: 'wind_dir')
  final double? windDir;
  @JsonKey(name: 'wind_gust_spd')
  final double? windGustSpd; //	3.6

  ///Скорость ветра: 13.85 м/с
  @JsonKey(name: 'wind_spd')
  final double? windSpd;

  DailyDataDTO(
      {this.appMaxTemp,
      this.appMinTemp,
      this.clouds,
      this.cloudsHi,
      this.cloudsLow,
      this.cloudsMid,
      this.datetime,
      this.dewpt,
      this.highTemp,
      this.lowTemp,
      this.maxDhi,
      this.maxTemp,
      this.minTemp,
      this.moonPhase,
      this.moonPhaseLunation,
      this.moonRiseTs,
      this.moonSetTs,
      this.ozone,
      this.pop,
      this.precip,
      this.pres,
      this.rh,
      this.slp,
      this.snow,
      this.snowDepth,
      this.sunRiseTs,
      this.sunSetTs,
      this.temp,
      this.ts,
      this.uv,
      this.validDate,
      this.vis,
      this.weather,
      this.windCdir,
      this.windCdirFull,
      this.windDir,
      this.windGustSpd,
      this.windSpd});

  factory DailyDataDTO.fromJson(Map<String, dynamic> json) =>
      _$DailyDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DailyDataDTOToJson(this);
}

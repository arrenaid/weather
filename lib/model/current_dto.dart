import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/daily_weather_dto.dart';
part 'current_dto.g.dart';

@JsonSerializable()
class CurrentDTO {
  @JsonKey(name: 'app_temp')
  final double appTemp; //	19.3
  final double aqi; ///	87 Индекс качества воздуха
  @JsonKey(name: 'city_name')
  final String city; //	"Moscow"
  final double clouds; //	0
  @JsonKey(name: 'country_code')
  final String countryCode; //	"RU"
  final String datetime; //	"2025-08-30:20"
  final double dewpt; //	12.3
  final double dhi; //	0
  final double dni; //	0
  @JsonKey(name: 'elev_angle')
  final double elevAngle; ///	-22.9 Угол возвышения солнца
  final double ghi; ///	0 ghi (0), dni (0), dhi (0) — Показатели солнечной радиации: Все равны 0 (ночь).
  final double gust; ///	4.4 gust (4.4 м/с) — Порывы ветра: Максимальная скорость кратковременных порывов.
  @JsonKey(name: 'h_angle')
  final double hAngle; ///	-90 гол азимута солнца
  final double lat; //	55.75222
  final double lon; //	37.61556
  @JsonKey(name: 'ob_time')
  final String time; //	"2025-08-30 20:30"
  final String pod; //	"n"
  final double precip; //	0
  final double pres; //	996
  final double rh; //	63
  final double slp; //	1014
  final double snow; //	0
  @JsonKey(name: 'solar_rad')
  final double solarRad; //	0
  final List<String> sources; //"analysis""radar""satellite"
  @JsonKey(name: 'state_code')
  final String stateCode; //	"48"
  final String station; //	"UUEE"
  final String sunrise; //	"02:28"
  final String sunset; //	"16:25"
  final double temp; //	19.6
  final String timezone; //	"Europe/Moscow"
  final double ts; //	1756585844
  final double uv; //	0
  final double vis; //	16
  final DailyWeatherDTO
      weather; //*;//code	800 description"Clear sky" icon;//	"c01n"*/
  @JsonKey(name: 'wind_cdir')
  final String windCDir; //	"SW"
  @JsonKey(name: 'wind_cdir_full')
  final String windCDirFull; //	"southwest"
  @JsonKey(name: 'wind_dir')
  final double windDir; //	216
  @JsonKey(name: 'wind_spd')
  final double wind; //	1.8

  CurrentDTO(
      {required this.appTemp,
      required this.aqi,
      required this.city,
      required this.clouds,
      required this.countryCode,
      required this.datetime,
      required this.dewpt,
      required this.dhi,
      required this.dni,
      required this.elevAngle,
      required this.ghi,
      required this.gust,
      required this.hAngle,
      required this.lat,
      required this.lon,
      required this.time,
      required this.pod,
      required this.precip,
      required this.pres,
      required this.rh,
      required this.slp,
      required this.snow,
      required this.solarRad,
      required this.sources,
      required this.stateCode,
      required this.station,
      required this.sunrise,
      required this.sunset,
      required this.temp,
      required this.timezone,
      required this.ts,
      required this.uv,
      required this.vis,
      required this.weather,
      required this.windCDir,
      required this.windCDirFull,
      required this.windDir,
      required this.wind});

  factory CurrentDTO.fromJson(Map<String, dynamic> json) =>
      _$CurrentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentDTOToJson(this);
}

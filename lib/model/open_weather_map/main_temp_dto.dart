import 'package:json_annotation/json_annotation.dart';
part 'main_temp_dto.g.dart';

@JsonSerializable()
class MainTempDTO {
  final double? temp; //": 284.2,
  @JsonKey(name: 'feels_like')
  final double? feelsLike; //": 282.93,
  @JsonKey(name: 'temp_min')
  final double? tempMin; //": 283.06,
  @JsonKey(name: 'temp_max')
  final double? tempMax; //": 286.82,
  final double? pressure; //": 1021,
  final double? humidity; //": 60,
  @JsonKey(name: 'sea_level')
  final double? seaLevel; //": 1021,
  @JsonKey(name: 'grnd_level')
  final double? groundLevel; //": 910
  @JsonKey(name: 'temp_kf')
  final double? tempKf;

  MainTempDTO({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.groundLevel,
    this.tempKf,
  });

  factory MainTempDTO.fromJson(Map<String, dynamic> json) =>
      _$MainTempDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MainTempDTOToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'rain_dto.g.dart';

@JsonSerializable()
class RainDTO {
  @JsonKey(name: '1h')
  final double? oneHour; //": 2.73
  @JsonKey(name: '3h')
  final double? threeHour; //": 2.73

  RainDTO({this.oneHour, this.threeHour});

  factory RainDTO.fromJson(Map<String, dynamic> json) =>
      _$RainDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RainDTOToJson(this);
}

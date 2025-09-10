import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/daily_data_dto.dart';

part 'daily_response_dto.g.dart';

@JsonSerializable()
class DailyResponseDTO {
  @JsonKey(name: 'city_name')
  final String? city; //	"Moscow"
  @JsonKey(name: 'country_code')
  final String? countryCode; //	"RU"
  final List<DailyDataDTO>? data; //	(7)[ {…}, {…}, {…}, {…}, {…}, {…}, {…} ]
  final double? lat; //"55.75222"
  final double? lon; //	"37.61556"
  @JsonKey(name: 'state_code')
  final String? stateCode; //	"48"
  final String? timezone; //	"Europe/Moscow"

  DailyResponseDTO({
    this.city,
    this.countryCode,
    this.data,
    this.lat,
    this.lon,
    this.stateCode,
    this.timezone,
  });

  factory DailyResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$DailyResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DailyResponseDTOToJson(this);
}

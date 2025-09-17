import 'package:json_annotation/json_annotation.dart';
import 'city_dto.dart';
import 'forecast_dto.dart';
part 'forecast_response_dto.g.dart';

@JsonSerializable()
class ForecastResponseDTO {
  final CityDTO city;
  final String? cod; //": "200",
  final double? message; //": 0.0582563,
  final int? cnt; //": 7,
  final List<ForecastDTO>? list;//

  ForecastResponseDTO({
    required this.city,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  factory ForecastResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ForecastResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastResponseDTOToJson(this);
}

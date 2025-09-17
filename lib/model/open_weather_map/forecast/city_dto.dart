import 'package:json_annotation/json_annotation.dart';
import '../coordinate_dto.dart';
part 'city_dto.g.dart';

@JsonSerializable()
class CityDTO {
  final int? id; //": 3163858,
  final String? name; //": "Zocca",
  final CoordinateDTO? coord; //"
  final String? country; //": "IT",
  final double? population; //": 4593,
  final double? timezone; //": 7200
  final double? sunrise; //": 1661834187,
  final double? sunset; //": 1661882248,

  CityDTO({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory CityDTO.fromJson(Map<String, dynamic> json) =>
      _$CityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CityDTOToJson(this);
}

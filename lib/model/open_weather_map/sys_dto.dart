import 'package:json_annotation/json_annotation.dart';
part 'sys_dto.g.dart';

@JsonSerializable()
class SysDTO {
  final double? type; //": 1,
  final double? id; //": 6736,
  final String? country;//": "IT",
  final double? sunrise; //": 1726636384,
  final double? sunset; //": 1726680975
  final String? message;

  SysDTO({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
    this.message,
  });

  factory SysDTO.fromJson(Map<String, dynamic> json) =>
      _$SysDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SysDTOToJson(this);
}
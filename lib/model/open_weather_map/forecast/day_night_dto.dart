import 'package:json_annotation/json_annotation.dart';
part 'day_night_dto.g.dart';

@JsonSerializable()
class DayNightDTO{
  final String? pod;

  DayNightDTO({this.pod});

  factory DayNightDTO.fromJson(Map<String, dynamic> json) =>
      _$DayNightDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DayNightDTOToJson(this);
}
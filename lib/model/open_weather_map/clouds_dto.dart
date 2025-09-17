import 'package:json_annotation/json_annotation.dart';
part 'clouds_dto.g.dart';

@JsonSerializable()
class CloudsDTO {
  final double? all; //83

  CloudsDTO({this.all});

  factory CloudsDTO.fromJson(Map<String, dynamic> json) =>
      _$CloudsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsDTOToJson(this);
}

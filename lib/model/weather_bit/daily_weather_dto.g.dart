// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeatherDTO _$DailyWeatherDTOFromJson(Map<String, dynamic> json) =>
    DailyWeatherDTO(
      icon: json['icon'] as String,
      code: (json['code'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$DailyWeatherDTOToJson(DailyWeatherDTO instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'code': instance.code,
      'description': instance.description,
    };

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/model/open_weather_map/current_weather_dto.dart';
import 'package:weather/model/open_weather_map/current_weather_dto_to_domain.dart';
import 'package:weather/model/open_weather_map/forecast/forecast_response_dto.dart';
import 'package:weather/model/open_weather_map/forecast/forecast_response_dto_to_domain.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/service/open_weather_map_query.dart';
import 'package:weather/service/repository_base.dart';

class OpenWeatherMapRepository extends RepositoryBase {
  late final Dio _dio;
  late final String _apiKey;
  final langRu = 'ru';
  final langEn = 'en';
  final cnt = 7;

  OpenWeatherMapRepository() {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(requestHeader: true, requestBody: true),
      ]);
  }

  @override
  Future<WeatherBase?> getCurrentWeather(String city) async {
    Response response = await _dio.get(OpenWeatherMapQuery.baseUrl +
        OpenWeatherMapQuery.currentWeatherEndPoint, queryParameters: {
      OpenWeatherMapQuery.city: city,
      OpenWeatherMapQuery.lang: langRu,
      OpenWeatherMapQuery.apiKey: _apiKey,
      OpenWeatherMapQuery.unitsKey: OpenWeatherMapQuery.unitsValue,
    });
    debugPrint(response.toString());

    var dto = CurrentWeatherDTO.fromJson(response.data as Map<String, dynamic>);
    debugPrint(dto.toString());

    WeatherBase base = dto.toDomain();
    return base;
  }

  @override
  Future<List<WeatherBase>?> getForecast(String city) async {
    Response response = await _dio.get(OpenWeatherMapQuery.baseUrl +
        OpenWeatherMapQuery.forecastEndPoint, queryParameters: {
      OpenWeatherMapQuery.city: city,
      //OpenWeatherMapQuery.cnt: cnt,
      OpenWeatherMapQuery.lang: langRu,
      OpenWeatherMapQuery.apiKey: _apiKey,
      OpenWeatherMapQuery.unitsKey: OpenWeatherMapQuery.unitsValue,
    });

    var dto = ForecastResponseDTO.fromJson(
        response.data as Map<String, dynamic>
    );
    debugPrint(dto.toString());

    List<WeatherBase> list = dto.toDomain();
    return list;
  }

  @override
  Future<void> setApiKey() async {
    await dotenv.load(fileName: ".env");
    _apiKey = dotenv.get('OPEN_WEATHER_MAP_API_KEY');
  }

}
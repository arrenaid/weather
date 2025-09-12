import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/model/weather_bit/current_dto.dart';
import 'package:weather/model/weather_bit/current_dto_to_domain.dart';
import 'package:weather/model/weather_bit/daily_response_dto_to_domain.dart';
import 'package:weather/service/repository_base.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/service/weatherbit_query.dart';
import '../model/weather_bit/daily_response_dto.dart';

class WeatherBitRepository extends RepositoryBase {
  late final Dio _dio;
  late final String _apiKey;

  WeatherBitRepository() {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(requestHeader: true, requestBody: true),
      ]);
  }

  @override
  Future<void> setApiKey() async {
    await dotenv.load(fileName: ".env");
    _apiKey = dotenv.get('WEATHERBIT_API_KEY');
  }

  @override
  Future<List<WeatherBase>?> getForecast(String city) async {
    Response response = await _dio.get(
        WeatherBitQuery.baseUrl + WeatherBitQuery.dailyEndPoint,
        queryParameters: {
          WeatherBitQuery.cityParameter: city,
          WeatherBitQuery.keyParameter: _apiKey,
        });
    debugPrint(response.toString());

    /// dto
    final DailyResponseDTO dto = DailyResponseDTO.fromJson(
      response.data as Map<String, dynamic>,
    );
    debugPrint(dto.toString());

    ///dto.toDomain
    final List<WeatherBase> forecast = dto.toDomain();
    return forecast;
  }

  @override
  Future<WeatherBase?> getCurrentWeather(String city) async {
    Response response = await _dio.get(
        WeatherBitQuery.baseUrl + WeatherBitQuery.currentEndPoint,
        queryParameters: {
          WeatherBitQuery.cityParameter: city,
          WeatherBitQuery.keyParameter: _apiKey,
        });
    debugPrint(response.toString());

    /// dto
    final CurrentDTO dto = CurrentDTO.fromJson(
      ((response.data as Map<String, dynamic>)['data'] as List<dynamic>).first
          as Map<String, dynamic>,
    );
    debugPrint(dto.toString());

    ///dto.toDomain
    final WeatherBase currentWeather = dto.toDomain();
    return currentWeather;
  }
}

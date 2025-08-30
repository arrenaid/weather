import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/model/current_dto.dart';
import 'package:weather/model/current_dto_to_domain.dart';
import 'package:weather/model/daily_response_dto.dart';
import 'package:weather/model/daily_response_dto_to_domain.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/model/weather_base_unit.dart';
import 'package:weather/service/weatherbit_query.dart';

class WeatherBitRepository {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  static late String _apiKey;

  static void setApiKey(String key) {
    _apiKey = key;
  }

  static Future<List<WeatherBase>?> getDailyForecastInCity(String city) async {
    try {
      Response response = await _dio.get(
          WeatherBitQuery.baseUrl + WeatherBitQuery.dailyEndPoint,
          queryParameters: {
            WeatherBitQuery.cityParameter: city,
            WeatherBitQuery.keyParameter: _apiKey,
          });
      debugPrint(response.toString());

      /// dto
      // final DailyDataDTO dto1 = DailyDataDTO.fromJson(response.data as  Map<String, dynamic>);
      // debugPrint(dto1.toString());
      final DailyResponseDTO dto = DailyResponseDTO.fromJson(
        response.data as Map<String, dynamic>,
      );
      debugPrint(dto.toString());

      ///dto.toDomain
      final List<WeatherBase> forecast = dto.toDomain();
      return forecast;
    } on DioException catch (_) {
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<WeatherBase?> getCurrentWeatherInCity(String city) async {
    try {
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
    } on DioException catch (_) {
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}

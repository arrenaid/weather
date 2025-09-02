import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather/model/current_dto.dart';
import 'package:weather/model/current_dto_to_domain.dart';
import 'package:weather/model/daily_response_dto.dart';
import 'package:weather/model/daily_response_dto_to_domain.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/service/weatherbit_query.dart';

class WeatherBitRepository {
  late final Dio _dio;
  final Function(String, String) onErrorHandler;
  late final String _apiKey;

  WeatherBitRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(requestHeader: true, requestBody: true),
        ErrorInterceptor(onErrorHandler),
      ]);

  }

  Future<void> setApiKey() async {
    await dotenv.load(fileName: ".env");
    _apiKey = dotenv.get('WEATHERBIT_API_KEY');
  }

  Future<List<WeatherBase>?> getDailyForecastInCity(String city) async {
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

  Future<WeatherBase?> getCurrentWeatherInCity(String city) async {

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

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor(this.onErrorHandler);

  Function(String, String) onErrorHandler;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    onErrorHandler(
      err.response?.statusCode.toString() ?? 'unknown',
      err.message.toString(),
    );
    handler.next(err);
    // super.onError(err, handler);
  }
}

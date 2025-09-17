import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/service/repository_base.dart';

class WeatherMapHelper extends RepositoryBase {
  late final String _apiKey;

  //запрос текущей погоды
  Future<dynamic> getWeather(String city) async {
    try {
      var parse = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=${city}&APPID=${_apiKey}&units=metric'); //&lang=ru
      http.Response response = await http.get(parse);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      } else {
        //return Future.error(response.statusCode);
        throw (response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  //погода на 5 дней через каждые 3 часа
  Future<List<Weather>?> getHourlyForecast(String city) async {
    var parse = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=${city}&APPID=${_apiKey}&units=metric&lang=ru');
    http.Response response = await http.get(parse);
    if (response.statusCode == 200) {
      try {
        var forecast = jsonDecode(response.body);
        List<Weather> weathers = [];

        int cnt = forecast['cnt'] ?? 40;
        for (int i = 0; i < cnt; i++) {
          weathers.add(
            Weather(
              city: forecast['city']['name'].toString(),
              description: forecast['list'][i]['weather'][0]['main'].toString(),
              iconName: forecast['list'][i]['weather'][0]['icon'].toString(),
              temperature:
                  double.parse(forecast['list'][i]['main']['temp'].toString()),
              feelsTemp: double.parse(
                  forecast['list'][i]['main']['feels_like'].toString()),
              minTemp: double.parse(
                  forecast['list'][i]['main']['temp_min'].toString()),
              maxTemp: double.parse(
                  forecast['list'][i]['main']['temp_max'].toString()),
              windSpeed:
                  double.parse(forecast['list'][i]['wind']['speed'].toString()),
              humidity: double.parse(
                  forecast['list'][i]['main']['humidity'].toString()),
              pressure: double.parse(
                  forecast['list'][i]['main']['pressure'].toString()),
              cloudiness:
                  double.parse(forecast['list'][i]['clouds']['all'].toString()),
              date: forecast['list'][i]['dt_txt'],
            ),
          );
        }
        return weathers;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return null;
  }

  @override
  Future<WeatherBase?> getCurrentWeather(String city) async {
    try {
      final map = await getWeather(city);
      //
      // dynamic map = await client.getWeather(state.city);
      var result = Weather.fromJson(map);
      WeatherBase base = WeatherBase(
        city: result.city,
        description: result.description,
        iconName: result.iconName,
        temperature: result.temperature,
        feelsTemp: result.feelsTemp,
        minTemp: result.minTemp,
        maxTemp: result.maxTemp,
        windSpeed: result.windSpeed,
        humidity: result.humidity,
        pressure: result.pressure,
        cloudiness: result.cloudiness,
        date: DateTime.now().toString(),
      );
      return base;
    } on SocketException catch (e) {
      debugPrint(e.toString());
      //emit(ErrorState('SocketException: $e', state.city));
    } on HttpException catch (e) {
      debugPrint(e.toString());
      // emit(ErrorState('HttpException: $e', state.city));
    } on FormatException catch (e) {
      debugPrint(e.toString());
      // emit(ErrorState('FormatException: $e', state.city));
    } catch (e) {
      debugPrint(e.toString());
      //emit(ErrorState(e.toString(), state.city));
    }
    return null;
  }

  @override
  Future<void> setApiKey() async {
    await dotenv.load(fileName: ".env");
    _apiKey = dotenv.get('OPEN_WEATHER_MAP_API_KEY');
  }

  @override
  Future<List<WeatherBase>?> getForecast(String city) async {
    List<Weather>? list = await getHourlyForecast(city);
    List<WeatherBase> baseList= [];
    if(list != null) {
      for (var result in list) {
        //var result = Weather.fromJson(map);
        WeatherBase base = WeatherBase(
          city: result.city,
          description: result.description,
          iconName: result.iconName,
          temperature: result.temperature,
          feelsTemp: result.feelsTemp,
          minTemp: result.minTemp,
          maxTemp: result.maxTemp,
          windSpeed: result.windSpeed,
          humidity: result.humidity,
          pressure: result.pressure,
          cloudiness: result.cloudiness,
          date: result.date,
        );
        baseList.add(base);
      }
    }
    return baseList;
  }
}

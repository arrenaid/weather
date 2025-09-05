import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/model/weather_base_unit.dart';
import 'package:weather/service/weatherbit_repository.dart';
import '../model/weather.dart';
import '../service/weather_map_helper.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherMapHelper client = WeatherMapHelper();

  // final WeatherBitRepository repository =
  //     WeatherBitRepository(onErrorHandler: (String p1, String p2) {});

  final String _sharedCityKey = 'city';
  final WeatherBitRepository repository;
  final String apiKey;

  WeatherBloc({required this.repository, required this.apiKey})
      : super(CityState('')) {
    on<CityEvent>(_cityChange);
    on<LoadWeatherEvent>(/*_connect*/ _connectWeatherBit);
    on<LoadForecastEvent>(_loadForecast);
    on<ErrorEvent>(_error);
    on<LoadCitySharedPreferencesEvent>(_load);
  }

  _load(LoadCitySharedPreferencesEvent event, Emitter emit) async {
    String city = await _loadCity();
    emit(CityState(city));
  }

  _error(ErrorEvent event, Emitter emit) {
    emit(ErrorState(event.message, state.city));
  }

  _cityChange(CityEvent event, Emitter emit) {
    emit(CityState(event.city));
  }

  ///old
    _connect(LoadWeatherEvent event, Emitter emit) async {
    try {
      dynamic map = await client.getWeather(state.city);
      Weather weather = Weather.fromJson(map);
      _saveCity(state.city);
      emit(LoadWeatherState(weather as WeatherBase, state.city));
    } on SocketException catch (e) {
      emit(ErrorState('SocketException: $e', state.city));
    } on HttpException catch (e) {
      emit(ErrorState('HttpException: $e', state.city));
    } on FormatException catch (e) {
      emit(ErrorState('FormatException: $e', state.city));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city));
    }
  }

  _connectWeatherBit(LoadWeatherEvent event, Emitter emit) async {
    // try {
    WeatherBase? currentWeather =
        await repository.getCurrentWeatherInCity(state.city);

    _saveCity(state.city);
    emit(LoadWeatherState(currentWeather!, state.city));
    // }on SocketException catch (e) { emit(ErrorState('SocketException: $e', state.city));
    // }on HttpException catch (e){  emit(ErrorState('HttpException: $e', state.city));
    // }on FormatException catch (e){  emit(ErrorState('FormatException: $e', state.city));
    // } catch (e) {
    //   emit(ErrorState(e.toString(), state.city));
    // }
  }

  _loadForecast(
      LoadForecastEvent event,
      /* WeatherBase current,*/
      Emitter emit) async {
    try {
      List<WeatherBase>? dailyForecast =
          await repository.getDailyForecastInCity(state.city);

      emit(LoadWeatherState(event.weather.toUnit(dailyForecast!), state.city));
    } on SocketException catch (e) {
      emit(ErrorState('SocketException: $e', state.city));
    } on HttpException catch (e) {
      emit(ErrorState('HttpException: $e', state.city));
    } on FormatException catch (e) {
      emit(ErrorState('FormatException: $e', state.city));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city));
    }
  }

  Future<void> _saveCity(String string) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_sharedCityKey, string);
    } catch (e) {
      print("--error--$e");
    }
  }

  Future<String> _loadCity() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_sharedCityKey);
      return result ?? '';
    } catch (e) {
      print("--error--$e");
      return '';
    }
  }
}

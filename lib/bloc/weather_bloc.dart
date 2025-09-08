import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/model/weather_base_unit.dart';
import 'package:weather/service/repository_base.dart';
import 'package:weather/service/weatherbit_repository.dart';
import '../service/weather_map_helper.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // final WeatherMapHelper client = WeatherMapHelper();

  // final WeatherBitRepository repository =
  //     WeatherBitRepository(onErrorHandler: (String p1, String p2) {});

  final String _sharedCityKey = 'city';
  final String _sharedRepositoryKey = 'repository';
  final List<RepositoryBase> repositories;
  // final String apiKey;

  WeatherBloc({required this.repositories})
      : super(CityState('', repositories.first)) {
    on<CityEvent>(_cityChange);
    on<LoadWeatherEvent>(/*_connect*/ _loadCurrentWeather);
    on<LoadForecastEvent>(_loadForecast);
    on<ErrorEvent>(_error);
    on<LoadCitySharedPreferencesEvent>(_load);
    on<ChangeRepositoryEvent>(_changeRepositoryQualifier);
  }

  _load(LoadCitySharedPreferencesEvent event, Emitter emit) async {
    String city = await _loadCity();
    var rep = await _loadRepository();
    emit(CityState(city, _selectedRepository(rep) ?? state.repository ));
  }

  _error(ErrorEvent event, Emitter emit) {
    emit(ErrorState(event.message, state.city,state.repository));
  }

  _cityChange(CityEvent event, Emitter emit) {
    emit(CityState(event.city,state.repository));
  }

  ///old
  //   _connect(LoadWeatherEvent event, Emitter emit) async {
  //   try {
  //     dynamic map = await client.getWeather(state.city);
  //     Weather weather = Weather.fromJson(map);
  //     _saveCity(state.city);
  //     emit(LoadWeatherState(weather as WeatherBase, state.city));
  //   } on SocketException catch (e) {
  //     emit(ErrorState('SocketException: $e', state.city));
  //   } on HttpException catch (e) {
  //     emit(ErrorState('HttpException: $e', state.city));
  //   } on FormatException catch (e) {
  //     emit(ErrorState('FormatException: $e', state.city));
  //   } catch (e) {
  //     emit(ErrorState(e.toString(), state.city));
  //   }
  // }

  _loadCurrentWeather(LoadWeatherEvent event, Emitter emit) async {
    try {
    WeatherBase? currentWeather =
        await state.repository.getCurrentWeather(state.city);

    _saveCity(state.city);
    emit(LoadWeatherState(currentWeather!, state.city, state.repository));
    }on SocketException catch (e) { emit(ErrorState('SocketException: $e', state.city, state.repository));
    }on HttpException catch (e){  emit(ErrorState('HttpException: $e', state.city, state.repository));
    }on FormatException catch (e){  emit(ErrorState('FormatException: $e', state.city, state.repository));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city, state.repository));
    }
  }

  _loadForecast(
      LoadForecastEvent event,
      /* WeatherBase current,*/
      Emitter emit) async {
    try {
      List<WeatherBase>? dailyForecast =
          await state.repository.getForecast(state.city);

      emit(LoadWeatherState(event.weather.toUnit(dailyForecast!), state.city, state.repository));
    } on SocketException catch (e) {
      emit(ErrorState('SocketException: $e', state.city, state.repository));
    } on HttpException catch (e) {
      emit(ErrorState('HttpException: $e', state.city, state.repository));
    } on FormatException catch (e) {
      emit(ErrorState('FormatException: $e', state.city, state.repository));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city, state.repository));
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

  Future<void> _saveRepository(String rep) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_sharedRepositoryKey, rep);
    } catch (e) {
      print("--error--$e");
    }
  }

  Future<RepositoryQualifier> _loadRepository() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_sharedRepositoryKey);
      var value;
      for( var e in RepositoryQualifier.values){
        if (e.name == result){
          value = e;
        }
      }

      return value ?? RepositoryQualifier.values.first;
    } catch (e) {
      print("--error--$e");
      return RepositoryQualifier.values.first;
    }
  }

  RepositoryBase? _selectedRepository(RepositoryQualifier value) {
    switch(value){
      case RepositoryQualifier.openWeatherMap:
        for(var e in repositories ){
          if(e is WeatherMapHelper){
            return e;
          }
        }
        break;
        default:
        for(var e in repositories ){
          if(e is WeatherBitRepository){
            return e;
          }
        }
    }
  }
  RepositoryQualifier getCurrentRepositoryQualifier() {
      if (state.repository is WeatherBitRepository) {
        return RepositoryQualifier.weatherBit;
      }
      return RepositoryQualifier.openWeatherMap;
  }

  FutureOr<void> _changeRepositoryQualifier(ChangeRepositoryEvent event, Emitter<WeatherState> emit) {
    _saveRepository(event.value.name);
    emit(CityState(state.city, _selectedRepository(event.value) ?? state.repository ));
  }
}

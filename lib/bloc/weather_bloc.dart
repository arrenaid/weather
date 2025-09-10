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

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // final WeatherMapHelper client = WeatherMapHelper();

  // final WeatherBitRepository repository =
  //     WeatherBitRepository(onErrorHandler: (String p1, String p2) {});

  final String _sharedCityKey = 'city';
  final String _sharedRepositoryKey = 'repository';
  final Map<RepositoryQualifier,RepositoryBase> repositories;
  // final String apiKey;

  WeatherBloc({required this.repositories})
      : super(CityState('', repositories.keys.first)) {
    on<CityEvent>(_cityChange);
    on<LoadWeatherEvent>(/*_connect*/ _loadCurrentWeather);
    on<LoadForecastEvent>(_loadForecast);
    on<ErrorEvent>(_error);
    on<LoadCitySharedPreferencesEvent>(_load);
    on<ChangeRepositoryEvent>(_changeRepositoryQualifier);
  }

  _load(LoadCitySharedPreferencesEvent event, Emitter emit) async {
    String city = await _loadCity();
    RepositoryQualifier qualifier = await _loadRepository();
    emit(CityState(city, qualifier));
  }

  _error(ErrorEvent event, Emitter emit) {
    emit(ErrorState(event.message, event.runtimeType.toString(), state.city,state.qualifier));
  }

  _cityChange(CityEvent event, Emitter emit) {
    emit(CityState(event.city,state.qualifier));
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
        await repositories[state.qualifier]!.getCurrentWeather(state.city);

    _saveCity(state.city);
    emit(LoadWeatherState(currentWeather!, state.city, state.qualifier));
    }on SocketException catch (e) { emit(ErrorState('SocketException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    }on HttpException catch (e){  emit(ErrorState('HttpException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    }on FormatException catch (e){  emit(ErrorState('FormatException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    } catch (e) {
      emit(ErrorState(e.toString(), e.runtimeType.toString(), state.city, state.qualifier));
    }
  }

  _loadForecast(
      LoadForecastEvent event,
      /* WeatherBase current,*/
      Emitter emit) async {
    try {
      List<WeatherBase>? dailyForecast =
          await repositories[state.qualifier]!.getForecast(state.city);

      emit(LoadWeatherState(event.weather.toUnit(dailyForecast!), state.city, state.qualifier));
    } on SocketException catch (e) {
      emit(ErrorState('SocketException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    } on HttpException catch (e) {
      emit(ErrorState('HttpException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    } on FormatException catch (e) {
      emit(ErrorState('FormatException: $e', e.runtimeType.toString(), state.city, state.qualifier));
    } catch (e) {
      emit(ErrorState('${e.runtimeType}: ${e.toString()}', e.runtimeType.toString(), state.city, state.qualifier));
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
      debugPrint("--error--$e");
      return '';
    }
  }

  Future<void> _saveRepository(String rep) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_sharedRepositoryKey, rep);
    } catch (e) {
      debugPrint("-> save repository ->  --error--$e");
    }
  }

  Future<RepositoryQualifier> _loadRepository() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_sharedRepositoryKey);
      var value;
      for( var e in RepositoryQualifier.values){
        if (e.name.toString() == result){
          value = e;
          debugPrint('-> load repository -> $e , value = ${value.toString()}');
        }
      }

      return value ?? RepositoryQualifier.values.first;
    } catch (e) {
      debugPrint("-> load repository -> --error-- $e");
      return RepositoryQualifier.values.first;
    }
  }

  FutureOr<void> _changeRepositoryQualifier(ChangeRepositoryEvent event, Emitter<WeatherState> emit) {
    _saveRepository(event.value.name);
    emit(CityState(state.city, event.value));
  }
}

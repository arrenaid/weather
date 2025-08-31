import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/model/weather_base_unit.dart';
import 'package:weather/service/weather_map_helper.dart';
import 'package:weather/service/weatherbit_repository.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherMapHelper client = WeatherMapHelper();
  final WeatherBitRepository repository = WeatherBitRepository();

  final String _sharedCityKey = 'city';

  WeatherBloc() : super(CityState('')) {
    on<CityEvent>(_cityChange);
    on<LoadWeatherEvent>(/*_connect*/_connectWeatherBit);
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

  _connect(LoadWeatherEvent event, Emitter emit) async {
    try {
      dynamic map = await client.getWeather(state.city);
      Weather weather = Weather.fromJson(map);
      _saveCity(state.city);
      emit(LoadWeatherState(weather as WeatherBase, state.city));
    }on SocketException catch (e) { emit(ErrorState('SocketException: $e', state.city));
    }on HttpException catch (e){  emit(ErrorState('HttpException: $e', state.city));
    }on FormatException catch (e){  emit(ErrorState('FormatException: $e', state.city));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city));
    }
  }

  _connectWeatherBit(LoadWeatherEvent event, Emitter emit) async {
    try {
      WeatherBase? currentWeather = await WeatherBitRepository.getCurrentWeatherInCity(state.city);

      _saveCity(state.city);
      emit(LoadWeatherState(currentWeather!, state.city));
    }on SocketException catch (e) { emit(ErrorState('SocketException: $e', state.city));
    }on HttpException catch (e){  emit(ErrorState('HttpException: $e', state.city));
    }on FormatException catch (e){  emit(ErrorState('FormatException: $e', state.city));
    } catch (e) {
      emit(ErrorState(e.toString(), state.city));
    }
  }
  _loadForecast(LoadForecastEvent event,/* WeatherBase current,*/ Emitter emit) async {
    try {
      List<WeatherBase>? dailyForecast = await WeatherBitRepository.getDailyForecastInCity(state.city);
      emit(LoadWeatherState(event.weather.toUnit(dailyForecast!), state.city));
    }on SocketException catch (e) { emit(ErrorState('SocketException: $e', state.city));
    }on HttpException catch (e){  emit(ErrorState('HttpException: $e', state.city));
    }on FormatException catch (e){  emit(ErrorState('FormatException: $e', state.city));
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

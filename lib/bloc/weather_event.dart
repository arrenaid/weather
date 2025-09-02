part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {}

class CityEvent extends WeatherEvent {
  final String city;

  CityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class LoadWeatherEvent extends WeatherEvent {
   final BuildContext context;

  LoadWeatherEvent(this.context);

  @override
  List<Object?> get props => [context];
}

class ErrorEvent extends WeatherEvent {
  final String message;

  ErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadCitySharedPreferencesEvent extends WeatherEvent {
  @override
  List<Object?> get props => [];
}

class LoadForecastEvent extends WeatherEvent {
  final WeatherBase weather;
  final BuildContext context;
  LoadForecastEvent(this.weather, this.context) : super();

  @override
  List<Object?> get props => [weather,context];
}

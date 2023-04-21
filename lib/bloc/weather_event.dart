part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable{

}
class CityEvent extends WeatherEvent{
  final String city;
  CityEvent(this.city);

  @override
  List<Object?> get props => [city];
}
class LoadWeatherEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}
class ErrorEvent extends WeatherEvent{
  final String message;

  ErrorEvent(this.message);
  @override
  List<Object?> get props => [message];
}
class LoadCitySharedPreferencesEvent extends WeatherEvent{
  @override
  List<Object?> get props => [];
}
part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable{
  final String city;

  const WeatherState(this.city);
}
class CityState extends WeatherState{
  const CityState( String city) : super(city) ;

  @override
  List<Object?> get props => [city];
}
class LoadWeatherState extends WeatherState{
  final Weather weather;
   const LoadWeatherState(this.weather, String city) : super(city) ;

  @override
  List<Object?> get props => [weather, city];
}
class ErrorState extends WeatherState{
  final String message;
  const ErrorState(this.message, String city) : super(city) ;

  @override
  List<Object?> get props => [message, city];
}
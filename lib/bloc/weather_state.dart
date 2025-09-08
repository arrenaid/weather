part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  final String city;
  final RepositoryBase repository;

  const WeatherState(this.city, this.repository);
}

class CityState extends WeatherState {
  const CityState(String city, RepositoryBase repository)
      : super(city, repository);

  @override
  List<Object?> get props => [city, repository];
}

class LoadWeatherState extends WeatherState {
  final WeatherBase weather;

  const LoadWeatherState(this.weather, String city, RepositoryBase repository)
      : super(city, repository);

  @override
  List<Object?> get props => [weather, city];
}

class ErrorState extends WeatherState {
  final String message;

  const ErrorState(this.message, String city, RepositoryBase repository)
      : super(city, repository);

  @override
  List<Object?> get props => [message, city];
}
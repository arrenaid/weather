part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  final String city;
  final RepositoryQualifier qualifier;

  const WeatherState(this.city, this.qualifier);
}

class CityState extends WeatherState {
  const CityState(String city, RepositoryQualifier qualifier)
      : super(city, qualifier);

  @override
  List<Object?> get props => [city, qualifier];
}

class LoadWeatherState extends WeatherState {
  final WeatherBase weather;

  const LoadWeatherState(this.weather, String city, RepositoryQualifier qualifier)
      : super(city, qualifier);

  @override
  List<Object?> get props => [weather, city];
}

class ErrorState extends WeatherState {
  final String message;
  final String type;

  const ErrorState(this.message, this.type, String city, RepositoryQualifier qualifier)
      : super(city, qualifier);

  @override
  List<Object?> get props => [message, city];
}
part of 'hourly_forecast_bloc.dart';

class HourlyForecastState extends Equatable {
  final List<WeatherBase> sorted;
  final List<WeatherBase> forecast;
  final int index;

  const HourlyForecastState({
    required this.sorted,
    required this.forecast,
    required this.index,
  });

  @override
  List<Object?> get props => [sorted, forecast, index];
}

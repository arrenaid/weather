part of 'hourly_forecast_bloc.dart';
class HourlyForecastEvent extends Equatable{
  const HourlyForecastEvent();
  @override
  List<Object?> get props => [];
}
class SetForecastEvent extends HourlyForecastEvent{
  final List<WeatherBase> forecast;

  const SetForecastEvent({required this.forecast});

  @override
  List<Object?> get props => [forecast];
}
class SetIndexEvent extends HourlyForecastEvent{
  final int index;
  const SetIndexEvent(this.index) : super();
  @override
  List<Object?> get props => [index];
}

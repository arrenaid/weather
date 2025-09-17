part of 'days_bloc.dart';

class DaysState extends Equatable {
  final List<WeatherBase> sorted;
  final List<WeatherBase> forecast;
  final int index;

  const DaysState({
    required this.sorted,
    required this.forecast,
    required this.index,
  });

  @override
  List<Object?> get props => [sorted, forecast, index];
}

class ErrorDaysState extends DaysState {
  final String message;

  const ErrorDaysState(this.message, weathersSort, weathersAll, indexSelected)
      : super(sorted: weathersSort, forecast:  weathersAll,index: indexSelected);

  @override
  List<Object?> get props => [message];
}

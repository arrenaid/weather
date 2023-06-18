part of 'days_bloc.dart';

class DaysState extends Equatable{
  final List<Weather> weathersSort;
  final List<Weather> weathersAll;
  final int indexSelected;
  const DaysState(this.weathersSort, this.weathersAll, this.indexSelected) ;

  @override
  List<Object?> get props => [weathersSort, weathersAll, indexSelected];
}
class ErrorDaysState extends DaysState{
  final String message;
   const ErrorDaysState(this.message, weathersSort,
       weathersAll, indexSelected)
       : super(weathersSort, weathersAll, indexSelected);

  @override
  List<Object?> get props => [message];
}
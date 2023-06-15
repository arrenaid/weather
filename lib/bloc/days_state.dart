part of 'days_bloc.dart';

class DaysState extends Equatable{
  final List<Weather> weathersSort;
  final List<Weather> weathersAll;
  const DaysState(this.weathersSort, String city, this.weathersAll) ;

  @override
  List<Object?> get props => [weathersSort, weathersAll];
}
class ErrorDaysState extends DaysState{
  final String message;
   ErrorDaysState(this.message) : super([], '', []);

  @override
  List<Object?> get props => [message];
}
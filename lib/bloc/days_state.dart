part of 'days_bloc.dart';

class DaysState extends Equatable{
  final List<Weather> weathers;
  const DaysState(this.weathers, String city) ;

  @override
  List<Object?> get props => [weathers];
}
class ErrorDaysState extends DaysState{
  final String message;
   ErrorDaysState(this.message) : super([], '');

  @override
  List<Object?> get props => [message];
}
part of 'days_bloc.dart';
class DaysEvent extends Equatable{
  final String city;
  DaysEvent(this.city);

  @override
  List<Object?> get props => [city];
}
class ErrorDaysEvent extends DaysEvent{
  final String message;

  ErrorDaysEvent(this.message,String city) : super(city);
  @override
  List<Object?> get props => [message];
}

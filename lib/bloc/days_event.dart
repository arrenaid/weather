part of 'days_bloc.dart';
class DaysEvent extends Equatable{
  const DaysEvent();
  @override
  List<Object?> get props => [];
}
class LoadDaysEvent extends DaysEvent{
  final String city;
  const LoadDaysEvent(this.city);

  @override
  List<Object?> get props => [city];
}
// class ErrorDaysEvent extends DaysEvent{
//   final String message;
//   const ErrorDaysEvent(this.message) : super();
//   @override
//   List<Object?> get props => [message];
// }
class SelectedDaysEvent extends DaysEvent{
  final int index;
  const SelectedDaysEvent(this.index) : super();
  @override
  List<Object?> get props => [index];
}

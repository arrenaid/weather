part of 'error_bloc.dart';

class ErrorEvent extends Equatable {
  const ErrorEvent();

  @override
  List<Object?> get props => [];
}

class ShowError extends ErrorEvent {
  final String title;
  final String message;

  const ShowError({required this.title, required this.message});

  @override
  List<Object> get props => [title, message];
}

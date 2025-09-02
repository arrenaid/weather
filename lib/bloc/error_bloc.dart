import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/widgets/show_error.dart';

part 'error_state.dart';

part 'error_event.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc(): super(const ErrorState()) {
    on<ShowError>(_showError);
  }

  _showError(ShowError event, Emitter emit) {
    showError(error: '${event.title} ${event.message}');
  }
}

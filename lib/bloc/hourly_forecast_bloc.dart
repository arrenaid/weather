import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_base.dart';

part 'hourly_forecast_event.dart';

part 'hourly_forecast_state.dart';

class HourlyForecastBloc extends Bloc<HourlyForecastEvent, HourlyForecastState> {
  HourlyForecastBloc()
      : super(const HourlyForecastState(sorted: [], forecast: [], index: 0)) {
    on<SetIndexEvent>(_change);
    on<SetForecastEvent>(_forecast);
  }

  _forecast(SetForecastEvent event, Emitter emit) async {
    var forecast = event.forecast;
    emit(HourlyForecastState(
      sorted: _sortForecast(state.index, forecast),
      forecast: forecast,
      index: state.index,
    ));
  }

  _change(SetIndexEvent event, Emitter emit) {
    var getRes = _sortForecast(event.index, state.forecast);
    emit(HourlyForecastState(
        sorted: getRes, forecast: state.forecast, index: event.index));
  }

  List<WeatherBase> _sortForecast(
      int indexSelected, List<WeatherBase> forecast) {
    switch (indexSelected) {
      case 0:
        return forecast;
      case 1:
        return _toDay(forecast, '15:00');
      case 2:
        return _toDay(forecast, '09:00');
      case 3:
        return _toDay(forecast, '21:00');
      case 4:
        return _toDay(forecast, '03:00');
      default:
        return _sortCold(forecast);
    }
  }

  List<WeatherBase> _toDay(List<WeatherBase> forecast, String target) {
    List<WeatherBase> result = [];
    for (var item in forecast) {
      String time = DateFormat.Hm()
          .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.date));
      if (time == target) {
        //'15:00'
        result.add(item);
      }
    }
    return result;
  }

  List<WeatherBase> _sortCold(List<WeatherBase> forecast) {
    List<WeatherBase> result = [];
    int count = 0;
    for (var item in forecast) {
      //отделяю прогнозы по дням проверяя '15:00'
      String time = DateFormat.Hm()
          .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.date));
      //день нужен что бы получить точно селедующеие дни не включая сегодня
      var day = DateFormat.d()
          .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.date));
      if (time == '15:00') {
        if (day != DateFormat.d().format(DateTime.now()) && count < 3) {
          count++;
          result.add(item);
        }
      }
    }
    //сортировка по возростанию температуры
    result.sort((WeatherBase a, WeatherBase b) =>
        a.temperature.compareTo(b.temperature));
    return result;
  }
}

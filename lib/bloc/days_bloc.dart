import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/service/weather_map_helper.dart';
part 'days_event.dart';
part 'days_state.dart';

class DaysBloc extends Bloc<DaysEvent, DaysState> {


  DaysBloc() : super(
      const DaysState(sorted: [], forecast:  [],index:  0)) {
    on<SelectedDaysEvent>(_change);
    on<LoadDaysEvent>(_forecast);
  }

  _forecast(LoadDaysEvent event, Emitter emit) async {
    try {
      // final forecast = await client.getForecast(event.city);
      var forecast = event.forecast;
        emit(DaysState(sorted: _sortForecast(state.index, forecast),
            forecast: forecast,index:  state.index));
    }on SocketException catch (e) { emit(ErrorDaysState('SocketException: $e',
        state.sorted,state.forecast, state.index));
    }on HttpException catch (e){  emit(ErrorDaysState('HttpException: $e',
        state.sorted,state.forecast, state.index));
    }on FormatException catch (e){  emit(ErrorDaysState('FormatException: $e',
        state.sorted,state.forecast, state.index));
    }catch (e) {emit(ErrorDaysState(e.toString(),
        state.sorted,state.forecast, state.index));}
  }

  _change(SelectedDaysEvent event, Emitter emit){
    var getRes = _sortForecast(event.index, state.forecast);
    emit(DaysState(sorted:  getRes,forecast:  state.forecast,index:  event.index));
  }

  List<WeatherBase> _sortForecast(int indexSelected, List<WeatherBase> forecast){
    switch(indexSelected){
      case 0: return forecast;
      case 1: return _toDay(forecast, '15:00');
      case 2: return _toDay(forecast, '09:00');
      case 3: return _toDay(forecast, '21:00');
      case 4: return _toDay(forecast, '03:00');
      default: return _sortCold(forecast);
    }
  }

  List<WeatherBase> _toDay(List<WeatherBase> forecast, String target) {
    List<WeatherBase> result = [];
    for (var item in forecast) {
      String time = DateFormat.Hm()
          .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.date));
      if (time == target) {//'15:00'
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
    result.sort((WeatherBase a, WeatherBase b) => a.temperature.compareTo(b.temperature));
    return result;
  }
}
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service/weather_map_helper.dart';
part 'days_event.dart';
part 'days_state.dart';

class DaysBloc extends Bloc<DaysEvent, DaysState> {
  final WeatherMapHelper client = WeatherMapHelper();

  DaysBloc() : super(const DaysState([], [], 0)) {
    on<SelectedDaysEvent>(_change);
    on<LoadDaysEvent>(_forecast);
  }

  _forecast(LoadDaysEvent event, Emitter emit) async {
    try {
      final forecast = await client.getForecast(event.city);
        emit(DaysState(_getRes(state.indexSelected, forecast),
            forecast, state.indexSelected));
    }on SocketException catch (e) { emit(ErrorDaysState('SocketException: $e',
        state.weathersSort,state.weathersAll, state.indexSelected));
    }on HttpException catch (e){  emit(ErrorDaysState('HttpException: $e',
        state.weathersSort,state.weathersAll, state.indexSelected));
    }on FormatException catch (e){  emit(ErrorDaysState('FormatException: $e',
        state.weathersSort,state.weathersAll, state.indexSelected));
    }catch (e) {emit(ErrorDaysState(e.toString(),
        state.weathersSort,state.weathersAll, state.indexSelected));}
  }

  _change(SelectedDaysEvent event, Emitter emit){
    var getRes = _getRes(event.index, state.weathersAll);
    emit(DaysState(getRes, state.weathersAll, event.index));
  }

  List<Weather> _getRes(int indexSelected, List<Weather> forecast){
    switch(indexSelected){
      case 0: return forecast;
      case 1: return _toDay(forecast, '15:00');
      case 2: return _toDay(forecast, '09:00');
      case 3: return _toDay(forecast, '21:00');
      case 4: return _toDay(forecast, '03:00');
      default: return _sortCold(forecast);
    }
  }

  List<Weather> _toDay(List<Weather> forecast, String target) {
    List<Weather> result = [];
    for (Weather item in forecast) {
      String time = DateFormat.Hm()
          .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(item.date));
      if (time == target) {//'15:00'
          result.add(item);
      }
    }
    return result;
  }

  List<Weather> _sortCold(List<Weather> forecast) {
    List<Weather> result = [];
    int count = 0;
    for (Weather item in forecast) {
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
    result.sort((Weather a, Weather b) => a.temp.compareTo(b.temp));
    return result;
  }
}
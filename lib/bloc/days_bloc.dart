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

  DaysBloc() : super(const DaysState([], '', [])) {
    on<DaysEvent>(_forecast);
  }

  _forecast(DaysEvent event, Emitter emit) async {
    try {
      var forecast = await client.getForecast(event.city);
      List<Weather> buf = forecast;
      List<Weather> result = [];
      int count = 0;
      for (Weather item in buf) {
        //отделяю прогнозы по дням проверя '15:00'
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
        //сортировка по возростанию температуры
        result.sort((Weather a, Weather b) => a.temp.compareTo(b.temp));
        emit(DaysState(result, event.city, forecast));
      }
    }on SocketException catch (e) { emit(ErrorDaysState('SocketException: $e'));
    }on HttpException catch (e){  emit(ErrorDaysState('HttpException: $e'));
    }on FormatException catch (e){  emit(ErrorDaysState('FormatException: $e'));
    }catch (e) {emit(ErrorDaysState(e.toString()));}
  }
}

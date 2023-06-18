import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/model/weather.dart';

const _apiKey = '66e25765dcbcbb5a1a38eb7cb620c043';

class WeatherMapHelper {
  //запрос текущей погоды
  Future<dynamic> getWeather(String city) async {
    try{
    var parse = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=${city}&APPID=${_apiKey}&units=metric');
    http.Response response = await http.get(parse);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    } else {
      //return Future.error(response.statusCode);
      throw(response.statusCode);
    }
    }catch(e){
      rethrow;
    }
  }

  //погода на 5 дней через каждые 3 часа
  Future<dynamic> getForecast(String city) async {
    var parse = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=${city}&APPID=${_apiKey}&units=metric');
    http.Response response = await http.get(parse);
    if (response.statusCode == 200) {
      try {
      var forecast = jsonDecode(response.body);
      List<Weather> weathers = [];

        int cnt = forecast['cnt'] ?? 40;
        for (int i = 0; i < cnt; i++) {
          weathers.add(
            Weather(
              city: forecast['city']['name'].toString(),
              main: forecast['list'][i]['weather'][0]['main'].toString(),
              icon: forecast['list'][i]['weather'][0]['icon'].toString(),
              temp:
                  double.parse(forecast['list'][i]['main']['temp'].toString()),
              feels: double.parse(
                  forecast['list'][i]['main']['feels_like'].toString()),
              min: double.parse(
                  forecast['list'][i]['main']['temp_min'].toString()),
              max: double.parse(
                  forecast['list'][i]['main']['temp_max'].toString()),
              wind:
                  double.parse(forecast['list'][i]['wind']['speed'].toString()),
              humidity: double.parse(
                  forecast['list'][i]['main']['humidity'].toString()),
              pressure: double.parse(
                  forecast['list'][i]['main']['pressure'].toString()),
              clouds:
                  int.parse(forecast['list'][i]['clouds']['all'].toString()),
              date: forecast['list'][i]['dt_txt'],

            ),
          );
        }
        return weathers;
      } catch(e) {
        return Future.error(e);
      }
    }
  }
}

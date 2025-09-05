import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';

const _apiKey = '66e25765dcbcbb5a1a38eb7cb620c043';

class WeatherMapHelper {
  //запрос текущей погоды
  Future<dynamic> getWeather(String city) async {
    try {
      var parse = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=${city}&APPID=${_apiKey}&units=metric&lang=ru');
      http.Response response = await http.get(parse);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      } else {
        //return Future.error(response.statusCode);
        throw (response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }

  //погода на 5 дней через каждые 3 часа
  Future<dynamic> getForecast(String city) async {
    var parse = Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=${city}&APPID=${_apiKey}&units=metric&lang=ru');
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
              description: forecast['list'][i]['weather'][0]['main'].toString(),
              iconName: forecast['list'][i]['weather'][0]['icon'].toString(),
              temperature:
                  double.parse(forecast['list'][i]['main']['temp'].toString()),
              feelsTemp: double.parse(
                  forecast['list'][i]['main']['feels_like'].toString()),
              minTemp: double.parse(
                  forecast['list'][i]['main']['temp_min'].toString()),
              maxTemp: double.parse(
                  forecast['list'][i]['main']['temp_max'].toString()),
              windSpeed:
                  double.parse(forecast['list'][i]['wind']['speed'].toString()),
              humidity: double.parse(
                  forecast['list'][i]['main']['humidity'].toString()),
              pressure: double.parse(
                  forecast['list'][i]['main']['pressure'].toString()),
              cloudiness:
                  int.parse(forecast['list'][i]['clouds']['all'].toString()),
              date: forecast['list'][i]['dt_txt'],
            ),
          );
        }
        return weathers;
      } catch (e) {
        return Future.error(e);
      }
    }
  }
}

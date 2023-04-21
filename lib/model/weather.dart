//для описания основной информации приходящей от сервера
class Weather{
  late final String city;
  late final String main;
  late final double temp;
  late final double feels;
  late final double min;
  late final double max;
  late final double wind;
  late final double humidity;
  late final double pressure;
  late final int clouds;
  late final String date;

  Weather({ required this.city,
    required this.main,
      required this.temp,
      required this.feels,
      required this.min,
      required this.max,
      required this.wind,
      required this.humidity,
      required this.pressure,
      required this.clouds,
    required this.date,
  });

  Weather.fromJson(Map<String, dynamic> map){
    city = map['name'].toString();
      main = map['weather'][0]['main'].toString();
    temp = double.parse(map['main']['temp'].toString());
    feels = double.parse(map['main']['feels_like'].toString());
    min = double.parse(map['main']['temp_min'].toString());
    max = double.parse(map['main']['temp_max'].toString());
    wind = double.parse(map['wind']['speed'].toString());
    humidity = double.parse(map['main']['humidity'].toString());
    pressure = double.parse(map['main']['pressure'].toString());
    clouds = int.parse( map['clouds']['all'].toString());
  }

  @override
  String toString() {
    return 'Weather{city: $city, temp: $temp, feels: $feels, min: $min, max: $max, wind: $wind, humidity: $humidity, pressure: $pressure, clouds: $clouds}';
  }
}
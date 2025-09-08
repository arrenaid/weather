//для описания основной информации приходящей от сервера
class Weather{
  late final String city;
  late final String description;
  late final String iconName;
  late final double temperature;
  late final double feelsTemp;
  late final double minTemp;
  late final double maxTemp;
  late final double windSpeed;
  late final double humidity;
  late final double pressure;
  late final double cloudiness;
  late final String date;

  Weather({ required this.city,
    required this.description,
    required this.iconName,
      required this.temperature,
      required this.feelsTemp,
      required this.minTemp,
      required this.maxTemp,
      required this.windSpeed,
      required this.humidity,
      required this.pressure,
      required this.cloudiness,
    required this.date,
  });

  Weather.fromJson(Map<String, dynamic> map){
    city = map['name'].toString();
      description = map['weather'][0]['main'].toString();
    iconName = map['weather'][0]['icon'].toString();
    temperature = double.parse(map['main']['temp'].toString());
    feelsTemp = double.parse(map['main']['feels_like'].toString());
    minTemp = double.parse(map['main']['temp_min'].toString());
    maxTemp = double.parse(map['main']['temp_max'].toString());
    windSpeed = double.parse(map['wind']['speed'].toString());
    humidity = double.parse(map['main']['humidity'].toString());
    pressure = double.parse(map['main']['pressure'].toString());
    cloudiness = double.parse( map['clouds']['all'].toString());
  }

  @override
  String toString() {
    return 'Weather{city: $city, main: $description, icon: $iconName, temp: $temperature, feels: $feelsTemp, min: $minTemp, max: $maxTemp, wind: $windSpeed, humidity: $humidity, pressure: $pressure, clouds: $cloudiness}';
  }
}
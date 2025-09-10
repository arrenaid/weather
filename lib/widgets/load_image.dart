import 'package:flutter/material.dart';
import '../constants.dart';

class LoadImage extends StatelessWidget {
  const LoadImage(
      {Key? key, required this.iconName, required this.qualifier, this.height})
      : super(key: key);
  final String iconName;
  final RepositoryQualifier qualifier;
  final queryOpenWeatherMap = 'https://openweathermap.org/img/wn/'; //04n@2x.png
  final size = '@2x';
  final end = '.png';
  final queryWeatherBit = 'https://cdn.weatherbit.io/static/img/icons/';
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/weather.png',
      placeholderCacheWidth: 50,
      image: getUrl(),
      fit: BoxFit.cover,
      //color: Colors.black,
      height: height,
      imageErrorBuilder: (context, error, trace) =>
          Image.asset('assets/images/weather.png'),
    );
  }

  String getUrl() {
    switch (qualifier) {
      case RepositoryQualifier.openWeatherMap:
        return queryOpenWeatherMap + iconName + size + end;
      case RepositoryQualifier.weatherBit:
        return queryWeatherBit + iconName + end;
    }
  }
}

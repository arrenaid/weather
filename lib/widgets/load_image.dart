import 'package:flutter/material.dart';

class LoadImage extends StatelessWidget {
  const LoadImage(
      {Key? key, required this.iconName, this.isBit = false, this.height})
      : super(key: key);
  final String iconName;
  final bool isBit;
  final queryOpenWeatherMap = 'https://openweathermap.org/img/wn/'; //04n@2x.png
  final size = '@2x';
  final end = '.png';
  final queryWeatherBit = 'https://cdn.weatherbit.io/static/img/icons/';
  final double? height;

  @override
  Widget build(BuildContext context) {
    final url = (isBit ? queryWeatherBit : queryOpenWeatherMap) +
        iconName +
        (isBit ? '' : size) +
        end;
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/weather.png',
      placeholderCacheWidth: 50,
      image: url,
      //'https://openweathermap.org/img/wn/$icon@2x.png',
      fit: BoxFit.cover,
      //color: Colors.black,
      height: height,
      imageErrorBuilder: (context, error, trace) =>
          Image.asset('assets/images/weather.png'),
    );
  }
}

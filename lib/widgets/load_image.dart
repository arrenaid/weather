import 'package:flutter/material.dart';
class LoadImage extends StatelessWidget {
  LoadImage({Key? key, required this.icon}) : super(key: key);
  final String icon;
  final query = 'https://openweathermap.org/img/wn/04n@2x.png';

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
        placeholder: 'assets/images/weather.png',
        placeholderCacheWidth: 50,
        image: 'https://openweathermap.org/img/wn/$icon@2x.png',
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, trace) =>
         Image.asset('assets/images/weather.png'),
    );
  }
}

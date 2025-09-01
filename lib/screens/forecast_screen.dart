import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/widgets/arrow_button.dart';
import '../bloc/weather_bloc.dart';
import '../constants.dart';
import '../widgets/load_image.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  static const String route = 'forecastScreen';

  @override
  Widget build(BuildContext context) {
    final Color currentClr = getCurrentColor();
    return Scaffold(
      backgroundColor: currentClr,
      body: GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! > 0) {
            // Page backwards
            debugPrint('Move page backwards');
            Navigator.pop(context);
            //_goBack();
          }
        },
        child: SafeArea(
          child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {
            if (state is ErrorState) {
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                flushbarStyle: FlushbarStyle.FLOATING,
                titleText: const Text(
                  'Ошибка',
                  style: tsCity,
                ),
                messageText: Text(
                  state.message,
                  style: tsMini,
                ),
                duration: const Duration(seconds: 5),
                isDismissible: true,
                borderRadius: BorderRadius.circular(15),
                backgroundGradient: bdGradient,
                borderWidth: 2,
                borderColor: Colors.white,
                margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
              ).show(context);
            }
          }, builder: (context, state) {
            if (state is LoadWeatherState) {
              if (state.weather.weeklyForecast != null) {
                return ForecastListView(
                  forecast: state.weather.weeklyForecast!
                      .sublist(1, state.weather.weeklyForecast!.length),
                  city: state.city,
                  color: currentClr,
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}

class ForecastListView extends StatelessWidget {
  const ForecastListView({
    super.key,
    required this.forecast,
    required this.city,
    required this.color,
  });

  final List<WeatherBase> forecast;
  final String city;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 25,
            child: Align(
              alignment: const FractionalOffset(0, 0),
              child: Transform.rotate(
                angle: pi,
                  child: ArrowButton(execute: () => Navigator.pop(context))),
            ),
          ),
          ///title
          Text(
            '$city forecast'.toUpperCase(),
            style: tsTitleBolt.copyWith(fontSize: 35),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forecast.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return ForecastDailyCard(
                backgroundColor: color,
                  weather: forecast[index],
                  color: getCurrentColor(),
                  isSpecial: index % 2 == 0);
            },
          ),
          const SizedBox(height: 10),
          Align(
            alignment: const FractionalOffset(0, 0),
            child: Transform.rotate(
                angle: pi,
                child: ArrowButton(execute: () => Navigator.pop(context))),
          ),
        ],
      ),
    );
  }
}

class ForecastDailyCard extends StatelessWidget {
  const ForecastDailyCard({
    super.key,
    required this.color,
    required this.weather,
    required this.isSpecial,
    required this.backgroundColor,
  });

  final WeatherBase weather;
  final Color color;
  final bool isSpecial;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isSpecial ? 0 : 30,
        right: isSpecial ? 30 : 0,
      ),
      child: Column(
        children: [
          Align(
            alignment: FractionalOffset(isSpecial ? 0 : 1, 1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                DateFormat.MMMMEEEEd()
                    .format(DateFormat("yyyy-MM-dd") //yyyy-MM-dd hh:mm:ss
                        .parse(weather.date)),
                style: tsMini.copyWith(color: backgroundColor),
              ),
            ),
          ),
          Transform.rotate(
            angle: isSpecial ? -pi / 95 : pi / 95,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2.5, color: Colors.black)),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: Column(
                children: [
                  ///start
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LoadImage(
                          iconName: weather.icon, height: 50, isBit: true),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        child: Text(
                          weather.main,
                          style: tsMini.copyWith(color: color),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Temperature ', style: tsDefault),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        child: Text(
                          '${weather.temp.round()}°',
                          style: tsDefault.copyWith(color: color),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('max ', style: tsForecast),
                      Text('${weather.max.round()}° ',
                          style: tsForecast.copyWith(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                      const Text('min ', style: tsForecast),
                      Text('${weather.min.round()}° ',
                          style: tsForecast.copyWith(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                      Text('feels like it ',
                          style: tsForecast.copyWith(fontSize: 21)),
                      Text('${weather.feels.round()}° ',
                          style: tsForecast.copyWith(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),

                  if (weather.chanceOfPrecipitation != null) ...[
                    Row(
                      children: [
                        Text(
                            'probability of precipitation ${weather.chanceOfPrecipitation} %',
                            style: tsForecast),
                      ],
                    ),
                  ],

                  ///row column
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('humidity',
                                style: tsForecast.copyWith(color: color)),
                            Text('${weather.humidity.round()} %',
                                style: tsForecast.copyWith(
                                    fontWeight: FontWeight.bold, color: color)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          // border: Border.all(
                          //     color: Colors.black, width: 2.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${weather.pressure.round()}\nmmHg',
                                style: tsForecast.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            const Text('pressure', style: tsForecast),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('wind', style: tsForecast),
                            Text('${weather.wind.round()}\nm/s',
                                style: tsForecast.copyWith(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      if (weather.vision != null) ...[
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Text('${weather.vision!.round()} km',
                                  style: tsForecast.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('vision',
                                  style: tsForecast.copyWith(color: color)),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),

                  ///end
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

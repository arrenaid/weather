import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/screens/days_screen.dart';
import 'package:weather/screens/forecast_screen.dart';
import '../widgets/arrow_button.dart';
import '../widgets/black_rock_segment.dart';
import '../widgets/weekly_forecast_listview.dart';
import '../widgets/wind_sector.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);
  static const String route = 'weather';
  static final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color currentClr = getCurrentColor();
    return Scaffold(
      key: WeatherScreen.globalKey,
      backgroundColor: currentClr,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 500) {
            context.read<WeatherBloc>().add(LoadWeatherEvent(context));
          }
        },
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 500) {
            context
                .read<DaysBloc>()
                .add(LoadDaysEvent(context.read<WeatherBloc>().state.city));
            Navigator.pushNamed(
              context,
              DaysScreen.route,
            );
          } else if (dragEndDetails.primaryVelocity! > 500) {
            Navigator.pushNamed(context, CityScreen.route);
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
                  isDismissible: false,
                  borderRadius: BorderRadius.circular(15),
                  backgroundGradient: bdGradient,
                  borderWidth: 2,
                  borderColor: Colors.white,
                  margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                ).show(context);
              }
            },
            builder: (buildContext, state) {
              if (state is LoadWeatherState) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        ///city
                        Stack(
                          children: [
                            Align(
                              alignment: const FractionalOffset(0, 0.5),
                              child: ArrowButton(
                                width: 30,
                                height: 30,
                                isNotArrow: true,
                                execute: () => Navigator.pushNamed(
                                    context, CityScreen.route),
                              ),
                            ),
                            Align(
                              alignment: const FractionalOffset(0.5, 0.5),
                              child: Text(
                                state.weather.city.toUpperCase(),
                                style: tsTitleBolt,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        //Дата
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Text(
                            DateFormat.MMMMEEEEd().format(DateTime.now()),
                            style: tsMini.copyWith(color: currentClr),
                          ),
                        ),

                        Text(
                          state.weather.main,
                          style: tsDefault,
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: SingleChildScrollView(
                            //Под Норильск приходится подстраиваться
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              '${state.weather.temp.toInt().toString()}°',
                              style: tsBigTemp,
                            ),
                          ),
                        ),
                        Text(
                          'Ощущается как ${state.weather.feels.toInt().toString()}°',
                          style: tsLite,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Min: ${state.weather.min.toInt().toString()}°',
                              style: tsLite,
                            ),
                            Text(
                              'Max: ${state.weather.max.toInt().toString()}°',
                              style: tsLite,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        //черный блок
                        BlackRockSegment(
                          color: currentClr,
                          wind: state.weather.wind,
                          humidity: state.weather.humidity,
                          pressure: state.weather.pressure,
                          vision: state.weather.vision,
                        ),
                        const SizedBox(height: 15),
                        if (state.weather.weeklyForecast != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly forecast',
                                style: tsDefault.copyWith(fontSize: 20),
                              ),
                              ArrowButton(
                                execute: () => Navigator.pushNamed(
                                  context,
                                  ForecastScreen.route,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          WeeklyForecastListView(
                            forecast: state.weather.weeklyForecast!,
                          ),
                        ] else ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Load weekly forecast',
                                style: tsDefault.copyWith(fontSize: 20),
                              ),
                              ArrowButton(execute: () {
                                context.read<WeatherBloc>().add(
                                    LoadForecastEvent(state.weather, context));
                                //         Navigator.pushNamed(
                                //           context,
                                //           DaysScreen.route,
                                //         );
                              }),
                            ],
                          ),
                        ],
                        const SizedBox(height: 15),
                        CloudPerSnowSector(
                          clouds: state.weather.clouds.toDouble(),
                          precipitation: state.weather.precipitation!,
                          snow: state.weather.snow!,
                          dewPoint: state.weather.dewPoint,
                          chanceOfPrecipitation:
                              state.weather.chanceOfPrecipitation,
                          ozone: state.weather.ozone,
                          snowDepth: state.weather.snowDepth,
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: '${state.weather.airQualityIndex!.round()}',
                              style: tsBigTemp.copyWith(fontSize: 40),
                              children: [
                                TextSpan(
                                    text: ' индекс качества воздуха',
                                    style: tsForecast),
                              ]),
                        ),
                        const SizedBox(height: 15),
                        ///sun rise set
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2.5),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    CupertinoIcons.sun_max_fill,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Восход',
                                    style: tsLite.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  Text(
                                    '${state.weather.sunRise}',
                                    style:
                                        tsDefault.copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [

                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(

                                        'День',
                                        style: tsLite.copyWith(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentGeometry.centerLeft,
                                      child: Text(
                                        getDayTime(state.weather.sunRise!, state.weather.sunSet!),
                                        style:
                                        tsDefault,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentGeometry.centerRight,
                                      child: Text(
                                        'Ночь',
                                        style: tsLite.copyWith(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentGeometry.centerRight,
                                      child: Text(
                                        getNightTime(state.weather.sunRise!, state.weather.sunSet!),
                                        style:
                                        tsDefault,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                     Icon(
                                      CupertinoIcons.moon_fill,
                                      size: 40,
                                      color: currentClr,
                                    ),
                                    Text(
                                      'Закат',
                                      style: tsLite.copyWith(
                                          fontSize: 20, color: currentClr),
                                    ),
                                    Text(
                                      '${state.weather.sunSet}',
                                      style:
                                      tsDefault.copyWith(color: currentClr),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        ///wind
                        WindSector(
                          color: currentClr,
                          speed: state.weather.wind,
                          gusts: state.weather.windGusts!,
                          direction: state.weather.windDirection!,
                          directionShort: state.weather.windDirShort!,
                          directionFull: state.weather.windDirFull!,
                        ),
                        const SizedBox(height: 10),
                        if ((state.weather.sunRise != null) &&
                            (state.weather.sunSet != null)) ...[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 2.5, color: Colors.black),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'uv index ${state.weather.uvIndex}',
                                      style: tsDefault.copyWith(fontSize: 20),
                                    ),
                                    Text(
                                      'угол \nвозвышения ${state.weather.angleSunAzimuth}',
                                      style: tsDefault.copyWith(fontSize: 20),
                                    ),
                                    Text(
                                      'aзимут ${state.weather.angleSunAzimuth}',
                                      style: tsDefault.copyWith(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),

                        Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Восход луны ${state.weather.moonRise}',
                                  style: tsDefault.copyWith(color: currentClr),
                                ),
                                Text(
                                  'Закат луны ${state.weather.moonSet}',
                                  style: tsDefault.copyWith(color: currentClr),
                                ),
                                Text(
                                  'Фаза луны ${state.weather.moonPhase}',
                                  style: tsDefault.copyWith(color: currentClr),
                                ),
                              ],
                            )),

                        const SizedBox(height: 20),

                        ///end view
                      ],
                    ),
                  ),
                );
              }
              if (state is ErrorState) {
                return Column(
                  children: [
                    const Spacer(),
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/weather.png'),
                        height: 100,
                        width: 100,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Hero(
                      tag: 'black',
                      child: Container(
                        height: MediaQuery.of(context).size.height / 10,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black,
                        ),
                        child: Center(
                            child: Text(
                          'Проблема:\n${state.message}',
                          style: tsMini.copyWith(color: currentClr),
                        )),
                      ),
                    ),
                  ],
                );
              }
              if (state is CityState) {
                context.read<WeatherBloc>().add(LoadWeatherEvent(context));
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                );
              }
              return const LinearProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}

class CloudPerSnowSector extends StatelessWidget {
  const CloudPerSnowSector({
    super.key,
    required this.clouds,
    this.ozone,
    required this.precipitation,
    required this.snow,
    this.snowDepth,
    this.chanceOfPrecipitation,
    this.dewPoint,
  });

  final double clouds;
  final double? ozone;
  final double precipitation;
  final double snow;
  final double? snowDepth;
  final double? chanceOfPrecipitation;
  final double? dewPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).width - 60,
      decoration: BoxDecoration(
        border: Border.all(width: 2.5, color: Colors.black),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${clouds.round()}',
                        style: tsBigTemp.copyWith(fontSize: 40),
                        children: const [
                          TextSpan(text: '%\nОблочность', style: tsForecast),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${ozone}',
                        style: tsBigTemp.copyWith(fontSize: 40),
                        children: [
                          TextSpan(text: '\nозон', style: tsForecast),
                        ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${dewPoint!.round()}',
                        style: tsBigTemp.copyWith(fontSize: 40),
                        children: [
                          TextSpan(text: '°C\nТочка росы', style: tsForecast),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 2.5, color: Colors.white),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: '${chanceOfPrecipitation}',
                      style: tsBigTemp.copyWith(fontSize: 40),
                      children: [
                        TextSpan(
                            text: '%\nВероятность\nосадков\n',
                            style: tsForecast),
                      ]),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: '${precipitation}',
                      style: tsBigTemp.copyWith(fontSize: 40),
                      children: [
                        TextSpan(
                            text: 'мм\nОбьем\nосадков\n', style: tsForecast),
                      ]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 2.5, color: Colors.white),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: '${snow.round()}',
                      style: tsBigTemp.copyWith(fontSize: 40),
                      children: [
                        TextSpan(text: 'мм\nCнег', style: tsForecast),
                      ]),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: '${snowDepth?.round()}',
                      style: tsBigTemp.copyWith(fontSize: 40),
                      children: [
                        TextSpan(
                            text: 'мм\nВысота\nснежного\nпокрова',
                            style: tsForecast),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

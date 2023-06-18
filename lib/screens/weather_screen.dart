import 'dart:math';
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

class WeatherScreen extends StatelessWidget {
  WeatherScreen({Key? key}) : super(key: key);
  static const String route = 'weather';
  final String cityName = 'moscow';
  String iconName = '';

  @override
  Widget build(BuildContext context) {
    Color currentClr = colors[Random().nextInt(colors.length)];
    //colors.remove(currentClr);
    return Scaffold(
      backgroundColor: currentClr,
      appBar: AppBar(
        flexibleSpace: Hero(
          tag: 'up',
          child: Container(
            decoration: const BoxDecoration(gradient: bdGradient),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, CityScreen.route),
          icon: const Icon(CupertinoIcons.t_bubble_fill), //cloud_moon_rain_fill
        ),
        title: const Text(
          'Погода',
          style: tsCity,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<DaysBloc>()
                  .add(LoadDaysEvent(context.read<WeatherBloc>().state.city));
              Navigator.pushNamed(context, DaysScreen.route,);
            },
            icon: const Icon(CupertinoIcons.news_solid),
          )
        ],
      ),
      body: GestureDetector(
        // Using the DragEndDetails allows us to only fire once per swipe.
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 500) {
            // Swipe down gesture recognized
            print('Swipe down: $details');
            context.read<WeatherBloc>().add(LoadWeatherEvent());
          }
          // else if (details.velocity.pixelsPerSecond.dy < 0) {
          //   // Swipe up gesture recognized
          //   print('Swipe up: $details');
          // }
        },
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 500) {
            // Page forwards
            print('Move page forwards');
            context
                .read<DaysBloc>()
                .add(LoadDaysEvent(context.read<WeatherBloc>().state.city));
            Navigator.pushNamed(context, DaysScreen.route,);
            //_goForward();
          } else if (dragEndDetails.primaryVelocity! > 500) {
            // Page backwards
            print('Move page backwards');
            Navigator.pushNamed(context, CityScreen.route);
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
                iconName = state.weather.icon;
                return SingleChildScrollView(
                  //что бы избежать проблем на узких экранах
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        //city
                        Text(
                          state.weather.city.toUpperCase(),
                          style: tsTitleBolt,
                          textAlign: TextAlign.center,
                        ),
                        //Дата
                        Chip(
                          label: Text(
                            DateFormat.MMMMEEEEd().format(DateTime.now()),
                            style: tsMini.copyWith(color: currentClr),
                          ),
                          backgroundColor: Colors.black,
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
                        const SizedBox(
                          height: 45,
                        ),
                        //черный блок
                        Hero(
                          tag: 'black',
                          child: Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(brDef)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Ветер
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.wind,
                                      color: currentClr,
                                      size: 60,
                                    ),
                                    Text(
                                      '${state.weather.wind.toString()}м/с',
                                      style:
                                          tsMiniLite.copyWith(color: currentClr),
                                    ),
                                    Text('Ветер',
                                        style:
                                            tsMini.copyWith(color: currentClr)),
                                  ],
                                ),
                                //Важность
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.drop,
                                      color: currentClr,
                                      size: 60,
                                    ),
                                    Text(
                                      '${state.weather.humidity.toInt().toString()}%',
                                      style:
                                          tsMiniLite.copyWith(color: currentClr),
                                    ),
                                    Text('Влажность',
                                        style:
                                            tsMini.copyWith(color: currentClr)),
                                  ],
                                ),
                                //Давление
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.speedometer,
                                      color: currentClr,
                                      size: 60,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${state.weather.pressure.toInt().toString()} ',
                                          style: tsMiniLite.copyWith(
                                              color: currentClr),
                                        ),
                                        Text(
                                          'мм\nрт.\nст.',
                                          style:
                                              tsMini.copyWith(color: currentClr),
                                        ),
                                      ],
                                    ),
                                    Text('Давление',
                                        style:
                                            tsMini.copyWith(color: currentClr)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
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
                context.read<WeatherBloc>().add(LoadWeatherEvent());
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

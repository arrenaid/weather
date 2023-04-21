import 'dart:math';
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
  const WeatherScreen({Key? key}) : super(key: key);
  static const String route = 'weather';
  final String cityName = 'moscow';

  @override
  Widget build(BuildContext context) {
    var colors = [clr1, clr2, clr3, clr4];
    Color currentClr = colors[Random().nextInt(colors.length)];
    colors.remove(currentClr);
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
                  .add(DaysEvent(context.read<WeatherBloc>().state.city));
              Navigator.pushNamed(context, DaysScreen.route);
            },
            icon: const Icon(CupertinoIcons.news_solid),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 2),
                content: Text(
                  'Ошибка получения данных : ${state.message}',
                  //state.message,
                  style: tsCity,
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (buildContext, state) {
            if (state is LoadWeatherState) {
              return SingleChildScrollView(
                //что бы избежать проблем на узких экранах
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      //Дата

                      //city
                      Text(
                        state.weather.city.toUpperCase(),
                        style: tsTitleBolt,
                        textAlign: TextAlign.center,
                      ),
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
                      SingleChildScrollView(
                        //Под Норильск приходится подстраиваться
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Center(
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
            if (state is CityState) {
              context.read<WeatherBloc>().add(LoadWeatherEvent());
              return const CircularProgressIndicator();
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}

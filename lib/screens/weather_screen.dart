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
                                execute: () => Navigator.pushNamed(context, CityScreen.route),
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

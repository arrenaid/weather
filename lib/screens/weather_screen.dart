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
import 'package:weather/utils.dart';
import 'package:weather/widgets/arrow_paint.dart';
import 'package:weather/widgets/load_image.dart';
import '../widgets/air_quality_sector.dart';
import '../widgets/arrow_button.dart';
import '../widgets/humidity_pressure_vision_sector.dart';
import '../widgets/sun_rise_sector.dart';
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
                          state.weather.description,
                          style: tsDefault,
                          textAlign: TextAlign.center,
                        ),
                        Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            //Под Норильск приходится подстраиваться
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                  text: state.weather.temperature.round().toString(),
                                  style: tsBigTemp,
                                  children: [
                                    TextSpan(
                                      text: '°',
                                      style: tsLite.copyWith(fontSize: 180),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                    Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text:
                          'Ощущается как '.toUpperCase(),
                          style: tsLite.copyWith(fontSize: 30, letterSpacing: -1),
                            children: [
                        TextSpan(
                        text: '${state.weather.feelsTemp.round()}°',
                      style: tsDefault.copyWith(fontSize: 35),),],),
                        ),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: 'ОТ ',
                              style: tsLite.copyWith(fontSize: 35, letterSpacing: 5),
                              children: [
                                TextSpan(
                                  text: state.weather.minTemp.round().toString(),
                                  style: tsDefault.copyWith(fontSize: 35),),
                                 TextSpan(
                                  text: '°\t\t',
                                  style: tsBigTemp.copyWith(fontSize: 35),
                                ),
                                TextSpan(
                                  text: 'ДО ',
                                  style: tsLite.copyWith(fontSize: 35),
                                ),
                                TextSpan(
                                  text: state.weather.maxTemp.round().toString(),
                                  style: tsDefault.copyWith(fontSize: 35),),
                                TextSpan(
                                  text: '°',
                                  style: tsBigTemp.copyWith(fontSize: 35),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 15),
                        //черный блок
                        HumidityPressureVisionSector(
                          color: currentClr,
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
                                'Прогноз на ${state.weather.weeklyForecast!.length} дней',
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
                          iconName: state.weather.iconName,
                          color: currentClr,
                          clouds: state.weather.cloudiness.toDouble(),
                          precipitation: state.weather.precipitation!,
                          dewPoint: state.weather.dewPoint,
                          chanceOfPrecipitation:
                              state.weather.chanceOfPrecipitation,
                        ),

                        SnowSector(
                          currentClr: currentClr,
                          snow: state.weather.snowDepth,
                          snowDepth: state.weather.snowDepth,
                        ),
                        const SizedBox(height: 15),

                        AirQualitySector(
                          color: currentClr,
                          index: state.weather.airQualityIndex,
                          ozone: state.weather.ozone,
                        ),
                        const SizedBox(height: 15),

                        ///sun rise set
                        SunRiseSector(
                          color: currentClr,
                          sunRise: state.weather.sunRise,
                          sunSet: state.weather.sunSet,
                          timeZone: state.weather.timeZone,
                        ),
                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: decorationFill,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                    text: state.weather.angleElevationSun
                                        .toString(),
                                    style: tsBigTemp.copyWith(
                                        fontSize: 30,
                                        letterSpacing: -3,
                                        color: currentClr),
                                    children: [
                                      TextSpan(
                                          text: '°',
                                          style: tsLite.copyWith(
                                              fontSize: 30, color: currentClr)),
                                    ]),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: currentClr,
                                ),
                                child: Text(
                                  'Угол возвышения солндца',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: tsLite.copyWith(
                                    fontSize: 20,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              // Icon(
                              //   CupertinoIcons.sunrise_fill,
                              //   color: currentClr,
                              //   size: 30,
                              // ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        ///wind
                        WindSector(
                          color: currentClr,
                          speed: state.weather.windSpeed,
                          gusts: state.weather.windGusts!,
                          direction: state.weather.windDirection!,
                          directionShort: state.weather.windDirShort!,
                          directionFull: state.weather.windDirFull!,
                        ),

                        const SizedBox(height: 15),
                        if ((state.weather.uvIndex != null)) ...[
                          UvIndexSector(
                            currentClr: currentClr,
                            index: state.weather.uvIndex!,
                          ),
                          const SizedBox(height: 15),
                        ],
                        if ((state.weather.moonPhase != null)) ...[
                          MoonSector(
                            color: currentClr,
                            moonRise: state.weather.moonRise!,
                            moonSet: state.weather.moonSet!,
                            moonPhase: state.weather.moonPhase!,
                          ),
                          const SizedBox(height: 15),
                        ],
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

class MoonSector extends StatelessWidget {
  const MoonSector({
    super.key,
    required this.color,
    required this.moonRise,
    required this.moonSet,
    required this.moonPhase,
  });

  final Color color;
  final String moonRise;
  final String moonSet;
  final double moonPhase;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: 'Восход луны',
                        style: tsLite.copyWith(fontSize: 22, color: color),
                        children: [
                          TextSpan(
                            text: moonRise,
                            style: tsBigTemp.copyWith(fontSize: 25, color: color),
                          ),
                        ]),
                  ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: moonSet,
                        style: tsBigTemp.copyWith(fontSize: 25, color: color),
                        children: [
                          TextSpan(
                            text: 'Заход луны',
                            style: tsLite.copyWith(fontSize: 22, color: color),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Expanded(flex:1,
                child: Icon(CupertinoIcons.moon_stars_fill,color: color,)),
            Expanded(
              flex:2,
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text: (moonPhase * 100).round().toString(),
                    style: tsBigTemp.copyWith(fontSize: 40, color: color),
                    children: [
                      TextSpan(
                        text: '%',
                        style: tsLite.copyWith(fontSize: 22, color: color),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}

class UvIndexSector extends StatelessWidget {
  const UvIndexSector({
    super.key,
    required this.currentClr,
    required this.index,
  });

  final double index;
  final Color currentClr;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationBorder,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: decorationFill,
            alignment: const FractionalOffset(0.5, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 30),
                painter: UvIndexCustomPainter(color: currentClr, index: index),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text('uv', style: tsBigTemp.copyWith(fontSize: 40)),
                ),
                Expanded(
                  child: Text(
                    'index',
                    style: tsLite.copyWith(fontSize: 22),
                  ),
                ),
                Expanded(
                  child: Text(
                    index.round().toString(),
                    style: tsBigTemp.copyWith(fontSize: 40),
                  ),
                ),
                Expanded(
                  child: Text(
                    'из 11',
                    style: tsLite.copyWith(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SnowSector extends StatelessWidget {
  const SnowSector({
    super.key,
    required this.currentClr,
    required this.snow,
    required this.snowDepth,
  });

  final Color currentClr;
  final double? snow;
  final double? snowDepth;

  @override
  Widget build(BuildContext context) {
    if ((snowDepth != null && snowDepth! > 0) || snow != null
        ? snow! > 0
        : false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: decorationFill,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text.rich(
                      textAlign: TextAlign.left,

                      TextSpan(
                          text: '${snow?.round()}',
                          style:
                              tsBigTemp.copyWith(fontSize: 40, color: currentClr, letterSpacing: -1),
                          children: [
                            TextSpan(
                                text: 'мм/ч',
                                style: tsForecast.copyWith(color: currentClr)),
                            TextSpan(
                                text: '\nCнег',
                                style: tsDefault.copyWith(color: currentClr)),
                          ]),
                    ),
                  ),
                  Icon(CupertinoIcons.snow, size: 100, color: currentClr),
                ],
              ),
            ),
          ),
          if (snowDepth != null) ...[
            Text.rich(
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                  text: '${snowDepth!.round()}',
                  style: tsBigTemp.copyWith(fontSize: 40, letterSpacing: -1),
                  children: [
                    const TextSpan(text: 'мм', style: tsForecast),
                    TextSpan(
                        text: '\nВысота снежного\nпокрова',
                        style: tsDefault.copyWith(fontSize: 15)),
                  ]),
            )
          ]
        ],
      );
    } else {
      return Container();
    }
  }
}

class CloudPerSnowSector extends StatelessWidget {
  const CloudPerSnowSector({
    super.key,
    required this.clouds,
    required this.precipitation,
    this.chanceOfPrecipitation,
    this.dewPoint,
    required this.color,
    required this.iconName,
  });

  final Color color;
  final String iconName;
  final double clouds;
  final double precipitation;
  final double? chanceOfPrecipitation;
  final double? dewPoint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: decorationFill,
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.cloud_fill,
                      size: 50,
                      color: color,
                    ),
                    Text('Облочность',
                        style: tsForecast.copyWith(color: color)),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: '${clouds.round()}',
                          style: tsBigTemp.copyWith(
                              fontSize: 40, letterSpacing: -2, color: color),
                          children: [
                            TextSpan(
                                text: '%',
                                style: tsLite.copyWith(color: color)),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
              width: 150,
              height: 150,
              child: LoadImage(
                iconName: iconName,
                isBit: true,
              ),
            )),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (chanceOfPrecipitation != null) ...[
              Expanded(
                flex: 4,
                child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: '${chanceOfPrecipitation!.round()}',
                      style: tsBigTemp.copyWith(fontSize: 40),
                      children: [
                        const TextSpan(
                          text: '%',
                          style: tsLite,
                        ),
                        TextSpan(
                            text: '\nВероятность осадков',
                            style: tsDefault.copyWith(fontSize: 20)),
                      ]),
                ),
              ),
            ],
            if (precipitation != null) ...[
              Expanded(
                flex: 3,
                child: Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: 'Обьем осадков\n',
                      style: tsForecast,
                      children: [
                        TextSpan(
                          text: '${precipitation!.round()}',
                          style: tsBigTemp.copyWith(fontSize: 40),
                        ),
                        TextSpan(
                          text: 'мм',
                          style: tsLite.copyWith(fontSize: 22),
                        ),
                      ]),
                ),
              ),
            ],
            if (dewPoint != null) ...[
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: decorationFill,
                  child: Expanded(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: '${dewPoint!.round()}',
                          style: tsBigTemp.copyWith(fontSize: 40, color: color),
                          children: [
                            TextSpan(
                              text: '°',
                              style: tsLite.copyWith(fontSize: 22),
                            ),
                            TextSpan(
                                text: '\nТочка росы',
                                style: tsForecast.copyWith(color: color)),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/hourly_forecast_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/widgets/load_image.dart';
import '../utils.dart';
import '../widgets/arrow_button.dart';
import 'forecast_screen.dart';

class HourlyForecastScreen extends StatelessWidget {
  HourlyForecastScreen({Key? key}) : super(key: key);
  static const String route = 'days';

  // final List<String> tag = ['by the hour', 'by day', 'in the morning',
  //     'at nigh','on the deepest nights','cold'];
  final List<String> tag = [
    'на пять дней',
    'на дни',
    'на утра',
    'на вечера',
    'на ночи',
    'три самые холодные'
  ];

  @override
  Widget build(BuildContext context) {
    final currentClr = getCurrentColor();
    List<Color> clrs = [];
    clrs.addAll(colors);
    clrs.remove(currentClr);
    final secondClr = clrs[Random().nextInt(clrs.length)];

    return Scaffold(
      backgroundColor: currentClr,
      body: GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! > 0) {
            // Page backwards
            debugPrint('-> Move page backwards');
            Navigator.pop(context);
            //_goBack();
          }
        },
        child: SafeArea(
            child: BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
          builder: (context, state) {
            List<int> fullDaysIndexes = getIndexFullDay(
                forecast: state.forecast,
                qualifier: RepositoryQualifier.openWeatherMap);
            if (state.forecast.isNotEmpty) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 45,
                      child: OverflowBox(
                        maxWidth: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          padding: const EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int indexChip) {
                            return ChoiceChip(
                              shape: const StadiumBorder(
                                side:  BorderSide(color: Colors.black, width: 2),
                              ),
                              label: Text(tag[indexChip]),
                              labelStyle: tsMini.copyWith(
                                color: state.index == indexChip
                                    ? Colors.black
                                    : currentClr,
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.all(10),
                              selected: state.index == indexChip,
                              selectedColor: secondClr,
                              // disabledColor: Colors.black,
                              backgroundColor: Colors.black,
                              onSelected: (selected) {
                                context
                                    .read<HourlyForecastBloc>()
                                    .add(SetIndexEvent(indexChip));
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 8),
                          itemCount: tag.length,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.sorted.length,
                      itemBuilder: (context, index) {
                        if (state.index == 1) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ForecastDailyCard(
                              backgroundColor: currentClr,
                              weather: state.sorted[index],
                              color: getCurrentColor(),
                              isSpecial: index % 2 == 0,
                              qualifier: RepositoryQualifier.openWeatherMap,
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2.5),
                          child: HourlyWeatherItem(
                            weather: state.sorted[index],
                            color: currentClr,
                            topRadius: state.index == 0
                                ? index == 0 ||
                                        fullDaysIndexes.contains(index - 1)
                                    ? 35
                                    : 5
                                : brDef,
                            bottomRadius: state.index == 0
                                ? fullDaysIndexes.contains(index)
                                    ? 35
                                    : 5
                                : brDef,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (fullDaysIndexes.contains(index) &&
                            state.index == 0) {
                          return Center(
                            child: Text(
                              DateFormat.MMMMd().format(getDateFormat(
                                      RepositoryQualifier.openWeatherMap)
                                  .parse(state.sorted[index + 1].date)),
                              style: tsTitleBolt.copyWith(
                                  fontSize: 30, letterSpacing: 4),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Align(
                      alignment: const FractionalOffset(0, 0),
                      child: Transform.rotate(
                          angle: pi,
                          child: ArrowButton(
                              execute: () => Navigator.pop(context))),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                  child: Text(
                'Прогноз не загрузился',
                style: tsDefault,
              ));
            }
          },
        )),
      ),
    );
  }
}

class HourlyWeatherItem extends StatelessWidget {
  final WeatherBase weather;
  final Color color;
  final double topRadius;
  final double bottomRadius;

  const HourlyWeatherItem(
      {super.key,
      required this.weather,
      required this.color,
      required this.topRadius,
      required this.bottomRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
          bottomLeft: Radius.circular(bottomRadius),
          bottomRight: Radius.circular(bottomRadius),
        ),
        color: Colors.black,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    DateFormat.MMMd().add_Hm().format(
                        DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date)),
                    style: tsMini.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    weather.description.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: tsMini.copyWith(color: color),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Center(
                  child: Text(
                    '${weather.temperature.toInt().toString()}°',
                    style: tsTitleBolt.copyWith(color: color, fontSize: 70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                LoadImage(
                  height: 100,
                  iconName: weather.iconName,
                  qualifier: RepositoryQualifier.openWeatherMap,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                          text: 'Ощущается\n',
                          style: tsLite.copyWith(fontSize: 20, color: color),
                          children: [
                            TextSpan(
                                text: '${weather.feelsTemp.round()}',
                                style: tsBigTemp.copyWith(
                                    fontSize: 40, color: color)),
                            TextSpan(
                                text: '°',
                                style: tsLite.copyWith(
                                    fontSize: 40, color: color)),
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                          text: 'Ветер\n',
                          style: tsLite.copyWith(fontSize: 20, color: color),
                          children: [
                            TextSpan(
                                text: '${weather.windSpeed.round()}',
                                style: tsBigTemp.copyWith(
                                    fontSize: 40, color: color)),
                            TextSpan(
                                text: 'м/с',
                                style: tsLite.copyWith(
                                    fontSize: 20, color: color)),
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                if (weather.windGusts != null) ...[
                  Center(
                    child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                            text: 'Порывы\n',
                            style: tsLite.copyWith(fontSize: 20, color: color),
                            children: [
                              TextSpan(
                                  text: '${weather.windGusts!.round()}',
                                  style: tsBigTemp.copyWith(
                                      fontSize: 40, color: color)),
                              TextSpan(
                                  text: 'м/с',
                                  style: tsLite.copyWith(
                                      fontSize: 20, color: color)),
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: VerticalDivider(width: 2.5, color: color),
                  ),
                ],
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                          text: 'Влажность\n',
                          style: tsLite.copyWith(fontSize: 20, color: color),
                          children: [
                            TextSpan(
                                text: '${weather.humidity.round()}',
                                style: tsBigTemp.copyWith(
                                    fontSize: 40, color: color)),
                            TextSpan(
                                text: '%',
                                style: tsLite.copyWith(
                                    fontSize: 20, color: color)),
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                if (weather.chanceOfPrecipitation != null) ...[
                  Center(
                    child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                            text: 'Вероятность осадков\n',
                            style: tsLite.copyWith(fontSize: 20, color: color),
                            children: [
                              TextSpan(
                                  text:
                                      '${weather.chanceOfPrecipitation!.round()}',
                                  style: tsBigTemp.copyWith(
                                      fontSize: 40, color: color)),
                              TextSpan(
                                  text: '%',
                                  style: tsLite.copyWith(
                                      fontSize: 20, color: color)),
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: VerticalDivider(width: 2.5, color: color),
                  ),
                ],
                if (weather.precipitation != null) ...[
                  Center(
                    child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                            text: 'Осадки\n',
                            style: tsLite.copyWith(fontSize: 20, color: color),
                            children: [
                              TextSpan(
                                  text: '${weather.precipitation!.round()}',
                                  style: tsBigTemp.copyWith(
                                      fontSize: 40, color: color)),
                              TextSpan(
                                  text: 'мм/ч',
                                  style: tsLite.copyWith(
                                      fontSize: 20, color: color)),
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.5),
                    child: VerticalDivider(width: 2.5, color: color),
                  ),
                ],
                Center(
                  child: Text.rich(
                      textAlign: TextAlign.left,
                      TextSpan(
                          text: 'Давление\n',
                          style: tsLite.copyWith(fontSize: 20, color: color),
                          children: [
                            TextSpan(
                                text: '${weather.pressure.round()}',
                                style: tsBigTemp.copyWith(
                                    fontSize: 40, color: color)),
                            TextSpan(
                                text: 'мм.рт.ст',
                                style: tsLite.copyWith(
                                    fontSize: 20, color: color)),
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.5),
                  child: VerticalDivider(width: 2.5, color: color),
                ),
                if (weather.vision != null) ...[
                  Center(
                    child: Text.rich(
                        textAlign: TextAlign.left,
                        TextSpan(
                            text: 'Видимость\n',
                            style: tsLite.copyWith(fontSize: 20, color: color),
                            children: [
                              TextSpan(
                                  text: '${(weather.vision! / 1000).round()}',
                                  style: tsBigTemp.copyWith(
                                      fontSize: 40, color: color)),
                              TextSpan(
                                  text: 'км',
                                  style: tsLite.copyWith(
                                      fontSize: 20, color: color)),
                            ])),
                  )
                ],
              ],
            ),
          ),
          // Container(
          //   width: 50,
          //   color: Colors.pink,
          //   child: Wrap(
          //     direction: Axis.vertical,
          //     children: [],
          //   ),
          // ),
          // Expanded(
          //   child: Container(
          //     //width: MediaQuery.of(context).size.width/2,
          //
          //     child: Wrap(
          //       direction: Axis.horizontal,
          //       children: [
          //
          //         Text(
          //           'Порывы: ${weather.windGusts.toString()}м/с',
          //           style: tsMini.copyWith(color: color),
          //         ),
          //         const SizedBox(height: 15),
          //         Text(
          //           'Влажность: ${weather.humidity.toString()}%',
          //           style: tsMini.copyWith(color: color),
          //         ),
          //         Text(
          //           'Давление: ${weather.pressure.toString()}мм.рт.ст',
          //           style: tsMini.copyWith(color: color),
          //         ),
          //         Text(
          //           'Вероятность осадков: ${weather.chanceOfPrecipitation.toString()}%',
          //           style: tsMini.copyWith(color: color),
          //         ),
          //         Text(
          //           'Осадки: ${weather.precipitation.toString()}мм/ч',
          //           style: tsMini.copyWith(color: color),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //
          //         Column(
          //           children: [
          //
          //           ],
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

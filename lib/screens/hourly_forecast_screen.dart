import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/hourly_forecast_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/widgets/load_image.dart';
import '../utils.dart';

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
  // late final Color currentClr;
  // late final Color secondClr;
  // late final String title;

  @override
  Widget build(BuildContext context) {
    final title = context.read<WeatherBloc>().state.city;
    final currentClr = getCurrentColor();
    List<Color> clrs = [];
    clrs.addAll(colors);
    clrs.remove(currentClr);
    final secondClr = clrs[Random().nextInt(clrs.length)];


    return Scaffold(
      backgroundColor: currentClr,
      appBar: AppBar(
        flexibleSpace: Hero(
          tag: 'up',
          child: Container(
            decoration: const BoxDecoration(gradient: bdGradient),
          ),
        ),
        title: Text(
          'Прогноз $title',
          style: tsMini,
          overflow: TextOverflow.fade,
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! > 0) {
            // Page backwards
            print('Move page backwards');
            Navigator.pop(context);
            //_goBack();
          }
        },
        child: SafeArea(
            child: BlocBuilder<HourlyForecastBloc, HourlyForecastState>(
              builder: (context, state) {
                List<int> fullDaysIndexes = getIndexFullDay(
                    forecast: state.forecast, qualifier: RepositoryQualifier.openWeatherMap);
                if (state.forecast.isNotEmpty) {
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 35,
                        child: OverflowBox(
                          maxWidth: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int indexChip) {
                              return ChoiceChip(
                                label: Text(tag[indexChip]),
                                labelStyle: tsMini.copyWith(
                                  color: state.index == indexChip
                                      ? Colors.black
                                      : currentClr,
                                ),
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
                            separatorBuilder: (BuildContext context,
                                int index) => const SizedBox(width: 8),
                            itemCount: tag.length,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.sorted.length,
                          itemBuilder: (context, index) {
                            return HourlyWeatherItem(
                              weather: state.sorted[index], color: currentClr,);
                          },
                          separatorBuilder: (context, index) {
                            if (fullDaysIndexes.contains(index) &&
                                state.index == 0) {
                              return Center(
                                child: Text(
                                  DateFormat.MMMMd().format(getDateFormat(
                                      RepositoryQualifier.openWeatherMap)
                                      .parse(state.sorted[index].date)),
                                  style: tsDefault.copyWith(fontSize: 18),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ],
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

  const HourlyWeatherItem(
      {super.key, required this.weather, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(brDef),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            color: Colors.pink,
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    DateFormat.MMMMd().add_Hm().format(
                        DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date)),
                    style: tsMini.copyWith(color: Colors.black),
                  ),
                ),
                Text(
                  weather.description.toString(),
                  style: tsMini.copyWith(color: color),
                ),
                Text(
                  '${weather.temperature.toInt().toString()}°',
                  style: tsTitleBolt.copyWith(color: color),
                ),
                SizedBox(
                  width: 50,
                  child: LoadImage(
                    iconName: weather.iconName,
                    qualifier: RepositoryQualifier.openWeatherMap,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              //width: MediaQuery.of(context).size.width/2,

              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    'Ветер: ${weather.windSpeed.toString()}м/с',
                    style: tsMini.copyWith(color: color),
                  ),
                  Text(
                    'Порывы: ${weather.windGusts.toString()}м/с',
                    style: tsMini.copyWith(color: color),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Влажность: ${weather.humidity.toString()}%',
                    style: tsMini.copyWith(color: color),
                  ),
                  Text(
                    'Давление: ${weather.pressure.toString()}мм.рт.ст',
                    style: tsMini.copyWith(color: color),
                  ),
                  Text(
                    'Вероятность осадков: ${weather.chanceOfPrecipitation.toString()}%',
                    style: tsMini.copyWith(color: color),
                  ),
                  Text(
                    'Осадки: ${weather.precipitation.toString()}мм/ч',
                    style: tsMini.copyWith(color: color),
                  ),


                ],
              ),
            ),
          ),
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
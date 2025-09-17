import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather_base.dart';
import 'package:weather/widgets/load_image.dart';
import 'package:weather/widgets/show_error.dart';
import '../utils.dart';

class DaysScreen extends StatelessWidget {
  DaysScreen({Key? key}) : super(key: key);
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
  late final Color currentClr;
  late final Color secondClr;
  late final String title;

  @override
  Widget build(BuildContext context) {
    title = context.read<WeatherBloc>().state.city;
    currentClr = getCurrentColor();
    List<Color> clrs = [];
    clrs.addAll(colors);
    clrs.remove(currentClr);
    secondClr = clrs[Random().nextInt(clrs.length)];

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
            child: BlocConsumer<DaysBloc, DaysState>(
          listener: (context, state) {
            if (state is ErrorDaysState) {
              showErrorFlushbar(context: context, error: state.message);
            }
          },
          builder: (context, state) {
            if (state.forecast.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 35,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
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
                                  .read<DaysBloc>()
                                  .add(SelectedDaysEvent(indexChip));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 8,
                        ),
                        itemCount: tag.length,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.sorted.length,
                        itemBuilder: (context, index) {
                          return buildItems(state.sorted[index]);
                        }),
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

  Widget buildItems(WeatherBase weather) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(brDef),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Wrap(
            direction: Axis.vertical,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: currentClr,
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
                style: tsMini.copyWith(color: currentClr),
              ),
              Text(
                '${weather.temperature.toInt().toString()}°',
                style: tsTitleBolt.copyWith(color: currentClr),
              ),
              // LoadImage(icon: weather.icon),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoadImage(
                    iconName: weather.iconName,
                    qualifier: RepositoryQualifier.openWeatherMap,
                  ),
                  Column(
                    children: [
                      Text(
                        '${weather.windSpeed.toString()}м/с',
                        style: tsMini.copyWith(color: currentClr),
                      ),
                      Text(
                        'Ветер',
                        style: tsMini.copyWith(color: currentClr),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '${weather.humidity.toString()}%',
                        style: tsMini.copyWith(color: currentClr),
                      ),
                      Text(
                        'Влажность',
                        style: tsMini.copyWith(color: currentClr),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

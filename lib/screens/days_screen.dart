import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/widgets/load_image.dart';

class DaysScreen extends StatelessWidget {
  DaysScreen({Key? key}) : super(key: key);
  static const String route = 'days';
  // final List<String> tag = ['by the hour', 'by day', 'in the morning',
  //     'at nigh','on the deepest nights','cold'];
  final List<String> tag = ['на пять дней', 'на дни', 'на утра',
    'на вечера','на ночи','три самые холодные'];
  late final Color currentClr;
  late final Color secondClr;
  late String title;

  @override
  Widget build(BuildContext context) {
    title = context.read<WeatherBloc>().state.city;
    currentClr = colors[Random().nextInt(colors.length)];
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
        title: Text('Прогноз $title',
          style: tsCity,
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
              },
              builder: (context, state) {
                if(state.weathersAll.isNotEmpty) {
                  if (state is DaysState) {
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
                                    color: state.indexSelected == indexChip
                                        ? Colors.black : currentClr,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  selected: state.indexSelected == indexChip,
                                  selectedColor: secondClr,
                                  // disabledColor: Colors.black,
                                  backgroundColor: Colors.black,
                                  onSelected: (selected) {
                                    context.read<DaysBloc>()
                                        .add(SelectedDaysEvent(indexChip));
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context,
                                  int index) => const SizedBox(width: 8,),
                              itemCount: tag.length,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.weathersSort.length,
                              itemBuilder: (context, index) {
                                return buildItems(state.weathersSort[index]);
                              }),
                        ),

                      ],
                    );
                  }
                }
                if (state is ErrorDaysState) {
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
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 10,
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
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.black,
                      ));
                }
              },
            )),
      ),
    );
  }

  Widget buildItems(Weather weather) {
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
              Chip(label:  Text(
                DateFormat.MMMMd()
                    .add_Hm()
                    .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date)),
                style: tsMini.copyWith(color: Colors.black),
              ),
                backgroundColor: currentClr,
              ),
              Text(weather.main.toString(),
                style: tsMini.copyWith(color: currentClr),
              ),
              Text(
                '${weather.temp.toInt().toString()}°',
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
                  LoadImage(icon: weather.icon),
                  Column(
                    children: [
                      Text(
                        '${weather.wind.toString()}м/с',
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

import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather.dart';

class DaysScreen extends StatelessWidget {
  DaysScreen({Key? key}) : super(key: key);
  static const String route = 'days';

  late final Color currentClr;

  @override
  Widget build(BuildContext context) {
    currentClr = colors[Random().nextInt(colors.length)];
    return Scaffold(
      backgroundColor: currentClr,
      appBar: AppBar(
        flexibleSpace: Hero(
          tag: 'up',
          child: Container(
            decoration: const BoxDecoration(gradient: bdGradient),
          ),
        ),
      ),
      body: SafeArea(
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
          if (state is DaysState) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.weathersSort.length,
                itemBuilder: (context, index) {
                  return buildItems(state.weathersSort[index]);
                });
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
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ));
          }
        },
      )),
    );
  }

  Widget buildItems(Weather weather) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(brDef),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat.MMMMd()
                .add_Hm()
                .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date)),
            style: tsLite.copyWith(color: currentClr),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${weather.temp.toInt().toString()}°',
                style: tsTitleBolt.copyWith(color: currentClr),
              ),
              Text(
                '${weather.main.toString()}°',
                style: tsLite.copyWith(color: currentClr),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '${weather.wind.toString()}м/с',
                    style: tsLite.copyWith(color: currentClr),
                  ),
                  Text(
                    'Ветер',
                    style: tsMini.copyWith(color: currentClr),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '${weather.humidity.toString()}%',
                    style: tsLite.copyWith(color: currentClr),
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
    );
  }
}

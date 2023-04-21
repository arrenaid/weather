import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/model/weather.dart';

class DaysScreen extends StatelessWidget {
  DaysScreen({Key? key}) : super(key: key);
  static const String route = 'days';

  List<Color> colors = [clr1, clr2, clr3, clr4];
  late final Color currentClr;

  @override
  Widget build(BuildContext context) {
    currentClr = colors[Random().nextInt(colors.length)];
    return Scaffold(
      backgroundColor: currentClr,
      appBar: AppBar(flexibleSpace: Hero(
        tag: 'up',
        child: Container(
          decoration: const BoxDecoration( gradient:bdGradient ),
        ),
      ),
      ),
      body: SafeArea(child: BlocConsumer<DaysBloc, DaysState>(
        listener: (context, state) {
          if (state is ErrorDaysState) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              behavior: SnackBarBehavior.floating,
              margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/2),
              content: Text('Ошибка получения данных : ${state.message}',
                //state.message,
                style: tsCity,
              ),
              backgroundColor: Colors.red,
            )
            );
          }
        },
        builder: (context, state) {
          if (state is DaysState) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.weathers.length,
                itemBuilder: (context, index){
              return buildItems(state.weathers[index]);
            });
          } else {
            return const LinearProgressIndicator();
          }
        },
      )),
    );
  }
  Widget buildItems(Weather weather){
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
          Text(DateFormat.MMMMd().add_Hm().format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(weather.date)),
            style: tsLite.copyWith(color: currentClr),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${weather.temp.toInt().toString()}°',
                style: tsTitleBolt.copyWith(color: currentClr),
              ),
              Text('${weather.main.toString()}°',
                style: tsLite.copyWith(color: currentClr),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('${weather.wind.toString()}м/с',
                    style: tsLite.copyWith(color: currentClr),
                  ),Text('Ветер',
                    style: tsMini.copyWith(color: currentClr),
                  ),
                ],
              ),
              Column(
                children: [
                  Text('${weather.humidity.toString()}%',
                    style: tsLite.copyWith(color: currentClr),
                  ),Text('Влажность',
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

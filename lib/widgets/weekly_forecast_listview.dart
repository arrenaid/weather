import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/widgets/load_image.dart';
import '../constants.dart';
import '../model/weather_base.dart';

class WeeklyForecastListView extends StatelessWidget {
  const WeeklyForecastListView({
    super.key,
    required this.forecast,
  });

  final List<WeatherBase> forecast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: OverflowBox(
          maxWidth: MediaQuery.of(context).size.width,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 30),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.5, color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(brDef)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${forecast[index].temperature.round()}°',
                      style: tsDefault,
                    ),
                    LoadImage(iconName: forecast[index].iconName, isBit: true,height: 30,),
                    // const Image(
                    //   image: AssetImage('assets/images/weather.png'),
                    //   height: 30,
                    //   width: 30,
                    //   color: Colors.black,
                    // ),
                    Text(
              DateFormat.MMMd().format(DateFormat("yyyy-MM-dd").parse(forecast[index].date)),
                      style: tsDefault.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 15);
            },
            itemCount: forecast.length,
          ),
        ));
  }
}

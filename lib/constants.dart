import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
const TextStyle tsBigTemp = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w600,
  fontSize: 200,
  color: Colors.black,
);
const TextStyle tsDefault = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 30,
  color: Colors.black,
);
const TextStyle tsTitleBolt = TextStyle(
  fontSize: 45,
  fontFamily: 'Effra',
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);
const TextStyle tsLite = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w300,
  fontSize: 30,
  color: Colors.black87,
);
const TextStyle tsCity = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w300,
  fontSize: 25,
  color: Colors.white,
);
const TextStyle tsMiniLite = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 30,
  color: Colors.white,
  // shadows: [Shadow(
  //     offset: Offset(4.0, 4.0),
  //     blurRadius: 8.0,
  //     color: Colors.black87)],
);
const TextStyle tsForecast = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: Colors.black,
);
const TextStyle tsBLackRock = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w400,
  fontSize: 18,
);
const TextStyle tsMini = TextStyle(
  fontFamily: 'Effra',
  fontWeight: FontWeight.w600,
  fontSize: 15,
  color: Colors.white,
  // shadows: [Shadow(
  //     offset: Offset(4.0, 4.0),
  //     blurRadius: 8.0,
  //     color: Colors.deepPurple)],
);

const Color clr1 = Color(0xFFffe142);
const Color clr2 = Color(0xFF42c6ff);
const Color clr3 = Color(0xFFff64d4);
const Color clr4 = Color(0xFF32D463);
const List<Color> colors = [clr1, clr2, clr3, clr4];

const LinearGradient bdGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight, //Alignment(0.8, 1),
    colors: <Color>[
      clr1,
      clr2,
      clr3,
      clr4 //
    ],
    tileMode: TileMode.mirror,
);
const double brDef = 15;

double convertHpaToMRS (double value){
  ///1 гектопаскаль = 0.75 миллиметра ртутного столба.
  return (value * 0.75).round().toDouble();
}

Color getCurrentColor(){
  return colors[Random().nextInt(colors.length)];
}
double degreeToRadian(double degree){
  return degree * (pi / 180);
}
String getDayTime(String rise, String set){
  
  var sr = DateFormat("hh:mm").parse(rise);
  var ss = DateFormat("hh:mm").parse(set);
  final Duration difference =  sr.difference(ss) ;
  debugPrint(difference.toString());
  var result = DateFormat.Hm().format(DateTime(sr.year).add(difference));
  debugPrint(result);
  return result;
  // DateTime sunRise = DateTime.parse(rise);
  // DateTime sunSet = DateTime.parse(set);
  // var day = sunRise.difference(sunSet);
  // debugPrint(day.toString());
  // return  day.toString();
  //DateFormat.Hm().format(DateFormat("hh:mm").parse(day.toString()));
  // DateFormat.Hm()
  //     .format(DateFormat("hh:mm").parse(state.weather.sunSet!).difference(DateFormat("hh:mm").parse(state.weather.sunRise!)) as DateTime),
}
String getNightTime(String rise, String set){
  var sunRise = DateFormat("hh:mm").parse(rise);
  var sunSet = DateFormat("hh:mm").parse(set);
  final Duration difference =  sunSet.difference(sunRise) ;
  var result = DateFormat.Hm().format(DateTime(sunRise.year).add(difference));
  debugPrint(result);
  return result;
}
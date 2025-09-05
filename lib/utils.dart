import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'constants.dart';

String getLocalTime({required String time, required String zone}) {
  tz_data.initializeTimeZones();
  DateTime utcTime = DateFormat("hh:mm").parse(time);
  DateTime localTime = tz.TZDateTime.from(utcTime, tz.getLocation(zone));
  return DateFormat.Hm().format(localTime);
}

double convertHpaToMRS(double value) {
  ///1 гектопаскаль = 0.75 миллиметра ртутного столба.
  return (value * 0.75).round().toDouble();
}

Color getCurrentColor() {
  return colors[Random().nextInt(colors.length)];
}

double degreeToRadian(double degree) {
  return degree * (pi / 180);
}

String getDayTime(String rise, String set) {
  var sr = DateFormat("hh:mm").parse(rise);
  var ss = DateFormat("hh:mm").parse(set);
  final Duration difference = sr.difference(ss);
  debugPrint(difference.toString());
  var result = DateFormat.Hm().format(DateTime(sr.year).add(difference));
  debugPrint(result);
  return result;
}

String getNightTime(String rise, String set) {
  var sunRise = DateFormat("hh:mm").parse(rise);
  var sunSet = DateFormat("hh:mm").parse(set);
  final Duration difference = sunSet.difference(sunRise);
  var result = DateFormat.Hm().format(DateTime(sunRise.year).add(difference));
  debugPrint(result);
  return result;
}
String getTimeTimestamp(double time){
  final date = DateTime.fromMicrosecondsSinceEpoch(time.toInt());
  return DateFormat.Hm().format(date);
}

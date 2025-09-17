import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:weather/model/weather_base.dart';
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

String getTimeTimestamp(double time) {
  final date = DateTime.fromMicrosecondsSinceEpoch(time.toInt());
  return DateFormat.Hm().format(date);
}

DateFormat getDateFormat(RepositoryQualifier qualifier) {
  switch (qualifier) {
    case RepositoryQualifier.openWeatherMap:
      return DateFormat("yyyy-MM-dd hh:mm:ss");
    case RepositoryQualifier.weatherBit:
      return DateFormat("yyyy-MM-dd");
  }
}

String? getSunRiseOrSet(double? time, String? timezone) {
  if (timezone != null && time != null) {
    var rise = getTimeTimestamp(time);
    return getLocalTime(time: rise, zone: timezone);
  }
  return null;
}

String? getLocalTimeInUtcOnTimezone(double? utc, double? timezone) {
  if (utc != null) {
    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(utc.toInt() * 1000, isUtc: true);
    if (timezone != null) {
      DateTime result = time.add(Duration(seconds: timezone.toInt()));
      return DateFormat.Hm().format(result);
    }
  }
  return null;
}

List<int> getIndexFullDay({required List<WeatherBase> forecast,
    required RepositoryQualifier qualifier}) {
  var first = DateFormat.MMMd()
      .format(getDateFormat(qualifier).parse(forecast.first.date));
  List<int> result = [];
  for (int i = 0; i < forecast.length; i++) {
    var current = DateFormat.MMMd()
        .format(getDateFormat(qualifier).parse(forecast[i].date));
    if (first != current) {
      first = current;
      result.add(i);
    }
  }
  return result;
}

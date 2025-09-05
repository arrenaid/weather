import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../utils.dart';

class SunRiseSector extends StatelessWidget {
  const SunRiseSector({
    super.key,
    required this.color,
    required this.sunRise,
    required this.sunSet,
    required this.timeZone,
  });

  final Color color;
  final String? sunRise;
  final String? sunSet;
  final String? timeZone;

  @override
  Widget build(BuildContext context) {
    if (sunSet == null || sunRise == null || timeZone == null) {
      return Container();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  CupertinoIcons.sun_max_fill,
                  size: 40,
                  color: Colors.black,
                ),
                Text(
                  'Восход',
                  style: tsLite.copyWith(fontSize: 20, color: Colors.black),
                ),
                Text(
                  getLocalTime(time: sunRise!, zone: timeZone!),
                  style: tsDefault.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      getDayTime(sunRise!, sunSet!),
                      style: tsDefault,
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      'День',
                      style: tsLite.copyWith(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Text(
                      'Ночь',
                      style: tsLite.copyWith(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: AlignmentGeometry.centerRight,
                    child: Text(
                      getDayTime(sunSet!, sunRise!),
                      //getNightTime(sunRise!, sunSet!),
                      style: tsDefault,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.moon_fill,
                    size: 40,
                    color: color,
                  ),
                  Text(
                    'Закат',
                    style: tsLite.copyWith(fontSize: 20, color: color),
                  ),
                  Text(
                    getLocalTime(time: sunSet!, zone: timeZone!),
                    style: tsDefault.copyWith(color: color),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}

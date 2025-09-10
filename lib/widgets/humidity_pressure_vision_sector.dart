import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HumidityPressureVisionSector extends StatelessWidget {
  const HumidityPressureVisionSector({
    super.key,
    required this.color,
    required this.humidity,
    required this.pressure,
    this.vision,
  });

  final Color color;
  final double humidity;
  final double pressure;
  final double? vision;
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Hero(
        tag: 'black',
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: decorationFill,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Влажность
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(
                  //   CupertinoIcons.drop_fill,
                  //   color: color,
                  //   size: iconSize,
                  // ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${humidity.round()}',
                        style: tsBigTemp.copyWith(fontSize: 40, color: color),
                        children: [
                          TextSpan(
                            text: '%',
                            style: tsLite.copyWith(fontSize: 22, color: color),
                          ),
                          TextSpan(
                              text: '\nВлажность',
                              style: tsForecast.copyWith(color: color)),
                        ]),
                  ),
                ],
              ),
              //Давление
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Давление', style: tsForecast.copyWith(color: color)),

                  Row(
                    children: [
                      Text(
                        '${pressure.round()}',
                        style: tsBigTemp.copyWith(fontSize: 40, color: color),
                      ),
                      SizedBox(
                        height:70,
                        child: Stack(
                          children: [
                            Align(
                              alignment: const FractionalOffset(0.5, 0),
                              child: Text(
                                'мм',
                                style: tsLite.copyWith(fontSize: 22, color: color, wordSpacing: -5),
                              ),
                            ),
                            Align(
                              alignment: const FractionalOffset(0.5, 0.5),
                              child: Text(
                                'рт.',
                                style: tsLite.copyWith(fontSize: 22, color: color, wordSpacing: -5),
                              ),
                            ),
                            Align(
                              alignment: const FractionalOffset(0.5, 1),
                              child: Text(
                                'ст.',
                                style: tsLite.copyWith(fontSize: 22, color: color, wordSpacing: -5),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  // Icon(
                  //   Icons.speed_rounded,//speed
                  //   color: color,
                  //   size: iconSize,
                  // ),
                ],
              ),
              if(vision != null)...[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // Icon(Icons.visibility,
                  //   //CupertinoIcons.zzz,
                  //   color: color,
                  //   size: iconSize,
                  // ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${vision!.round()}',
                        style: tsBigTemp.copyWith(fontSize: 40, color: color),
                        children: [
                          TextSpan(
                            text: 'км',
                            style: tsLite.copyWith(fontSize: 22, color: color),
                          ),
                          TextSpan(
                              text: '\nВидимость',
                              style: tsForecast.copyWith(color: color)),
                        ]),
                  ),
                ],
              ),],
            ],
          ),
        ),
      ),
    );
  }
}

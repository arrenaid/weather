import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BlackRockSegment extends StatelessWidget {
  const BlackRockSegment({
    super.key,
    required this.color,
    required this.wind,
    required this.humidity,
    required this.pressure,
    this.vision,
  });

  final Color color;
  final double wind;
  final double humidity;
  final double pressure;
  final double? vision;
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'black',
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(brDef)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Ветер
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.wind,
                  color: color,
                  size: iconSize,
                ),
                Text(
                  '${wind.round()} м/с',
                  style: tsBLackRock.copyWith(color: color),
                ),
                Text('Ветер', style: tsMini.copyWith(color: color)),
              ],
            ),
            //Важность
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.drop,
                  color: color,
                  size: iconSize,
                ),
                Text(
                  '${humidity.round()} %',
                  style: tsBLackRock.copyWith(color: color),
                ),
                Text('Влажность', style: tsMini.copyWith(color: color)),
              ],
            ),
            //Давление
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.speedometer,
                  color: color,
                  size: iconSize,
                ),
                Row(
                  children: [
                    Text(
                      '$pressure ',
                      style: tsBLackRock.copyWith(color: color),
                    ),
                    Text(
                      'мм\nрт.\nст.',
                      style: tsBLackRock.copyWith(fontSize: 9, color: color),
                    ),
                  ],
                ),
                Text('Давление', style: tsMini.copyWith(color: color)),
              ],
            ),
            if(vision != null)...[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.visibility_outlined,
                  //CupertinoIcons.zzz,
                  color: color,
                  size: iconSize,
                ),
                Row(
                  children: [
                    Text(
                      '$vision m',
                      style: tsBLackRock.copyWith(color: color),
                    ),
                  ],
                ),
                Text('Видимость', style: tsMini.copyWith(color: color)),
              ],
            ),],
          ],
        ),
      ),
    );
  }
}

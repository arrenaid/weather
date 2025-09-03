import 'package:flutter/material.dart';
import '../constants.dart';
import 'arrow_paint.dart';

class WindSector extends StatelessWidget {
  const WindSector({
    super.key,
    required this.color,
    required this.speed,
    required this.gusts,
    required this.directionFull,
    required this.directionShort,
    required this.direction,
  });

  final Color color;
  final double speed;
  final double gusts;
  final String directionFull;
  final String directionShort;
  final double direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        //border: Border.all(width: 2.5, color: Colors.black),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    speed.round().toString(),
                    style: tsBigTemp.copyWith(color: color, fontSize: 60),
                  ),
                  Text(
                    'м/с\nВетер',
                    style: tsLite.copyWith(color: color, fontSize: 20),
                  ),
                ],
              ),
              Divider(
                height: 3,
                color: color,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    gusts.round().toString(),
                    style: tsBigTemp.copyWith(color: color, fontSize: 60),
                  ),
                  Text(
                    'м/с\nПорывы',
                    style: tsLite.copyWith(color: color, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: const FractionalOffset(0.5, 0.5),
                      child: Text(
                        directionShort,
                        style: tsBigTemp.copyWith(
                            color: color, letterSpacing: -5, fontSize: 40),
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.5, 0.1),
                      child: Text(
                        'N',
                        style: tsLite.copyWith(
                            color: color, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.5, 0.9),
                      child: Text(
                        'S',
                        style: tsLite.copyWith(
                            color: color, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.1, 0.5),
                      child: Text(
                        'W',
                        style: tsLite.copyWith(
                            color: color, fontSize: 15),
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.9, 0.5),
                      child: Text(
                        'E',
                        style: tsLite.copyWith(
                            color: color, fontSize: 15),
                      ),
                    ),
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: WindDirectionCustomPainter(color: color),
                    ),
                    Transform.rotate(
                      angle: degreeToRadian(direction),
                      child: CustomPaint(
                        size: const Size(200, 200),
                        painter: WindArrowCustomPainter(color: color),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                directionFull,
                style: tsLite.copyWith(color: color, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

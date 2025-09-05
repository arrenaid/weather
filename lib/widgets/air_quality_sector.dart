import 'package:flutter/material.dart';
import '../constants.dart';
import 'arrow_paint.dart';

class AirQualitySector extends StatelessWidget {
  const AirQualitySector({
    super.key,
    required this.color,
    this.index,
    this.ozone
  });

  final double? ozone;
  final double? index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (index == null) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: decorationFill,
        child: Column(
          children: [
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                  text: '${index!.round()}',
                  style: tsBigTemp.copyWith(fontSize: 40, color: color),
                  children: [
                    TextSpan(
                        text: '\tиндекс качества воздуха',
                        style: tsLite.copyWith(
                            fontSize: 22,
                            overflow: TextOverflow.ellipsis,
                            color: color)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 50),
                painter:
                    AirIndexScaleCustomPainter(color: color, index: index!),
              ),
            ),
            if(ozone != null)...[
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: color,
                ),
                child: Text.rich(
                  textAlign: TextAlign.right,
                  TextSpan(
                      text: 'озон',
                      style: tsLite.copyWith(
                          fontSize: 22,
                          overflow: TextOverflow.ellipsis,
                         ),
                      children: [
                        TextSpan(text: '\t${ozone!.round()}', style:tsBigTemp.copyWith(fontSize: 24),),
                      ]),
                ),
              ),
            ),],
          ],
        ),
      );
    }
  }
}

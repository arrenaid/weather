import 'dart:math' as math;

import 'package:flutter/material.dart';

class ArrowCustomPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;

  ArrowCustomPainter({
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.backgroundColor = Colors.transparent,
  });

  void drawRotated(
    Canvas canvas,
    Offset center,
    double angle,
    VoidCallback drawFunction,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = size.height/10;
    canvas.drawLine(Offset(0,size.height/2), Offset(size.width, size.height/2), paint);
    canvas.drawLine(Offset(size.width * 0.75 , size.height/4+ paint.strokeWidth/2), Offset(size.width, size.height/2 - paint.strokeWidth/2), paint);
    canvas.drawLine( Offset(size.width, size.height/2 + paint.strokeWidth/2), Offset(size.width * 0.75, size.height *3 / 4  - paint.strokeWidth/2), paint);

    // final arrowBodyHeight = size.height / 10;
    // final heightNotInUseAllSides = size.height / 2;
    // final arrowBodyWidth = size.width * 0.70;
    // final arrowPointPosition = size.height / 2;
    //
    // final center = Offset(size.width / 2, size.width / 2);
    // final rectWidth = size.width;
    // final rectHeight = size.height / 10;
    //
    // final rect = Rect.fromCenter(
    //   center: center,
    //   width: rectWidth,
    //   height: rectHeight,
    // );
    //
    // final rectTop = Rect.fromCircle(
    //     center: Offset(size.width, size.height / 2),
    //     radius: size.height * 0.20);
    // drawRotated(canvas, Offset(
    //   rectTop.top + (rectTop.width / 2),
    //   rectTop.left + (rectTop.height / 2),
    // ),
    //   math.pi / 2,
    //
    //       () => canvas.drawRect(rectTop, paint),
    // );
    //
    // final Path path = Path()..addRect(rect);
    //
    // // path.moveTo(0, heightNotInUseAllSides);
    // // path.lineTo(arrowBodyWidth, heightNotInUseAllSides);
    // // path.lineTo(arrowBodyWidth, 0);
    // //
    // // path.lineTo(size.width, arrowPointPosition);
    // // path.lineTo(arrowBodyWidth, size.height);
    // // path.lineTo(arrowBodyWidth, arrowBodyHeight + heightNotInUseAllSides);
    // // path.lineTo(0, arrowBodyHeight + heightNotInUseAllSides);
    // path.close();
    //
    // // final Path path_0 = Path();
    // // if (borderWidth > 0) {
    // //   final Paint paintStroke = Paint()
    // //     ..style = PaintingStyle.stroke
    // //     ..strokeWidth = borderWidth;
    // //   paintStroke.color = borderColor;
    // //   paintStroke.strokeCap = StrokeCap.round;
    // //   paintStroke.strokeJoin = StrokeJoin.round;
    // //   canvas.drawPath(path_0, paintStroke);
    // // }
    //
    // final paintFill = Paint()..style = PaintingStyle.fill;
    // paintFill.color = backgroundColor;
    // canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

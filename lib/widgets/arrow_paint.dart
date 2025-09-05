import 'dart:math';
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

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = size.height / 10;
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    canvas.drawLine(
        Offset(size.width * 0.75, size.height / 4 + paint.strokeWidth / 2),
        Offset(size.width, size.height / 2 - paint.strokeWidth / 2),
        paint);
    canvas.drawLine(
        Offset(size.width, size.height / 2 + paint.strokeWidth / 2),
        Offset(size.width * 0.75, size.height * 3 / 4 - paint.strokeWidth / 2),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DoubleLineCustomPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;

  DoubleLineCustomPainter({
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.backgroundColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = size.height / 10;
    canvas.drawLine(Offset(0, size.height * 0.35),
        Offset(size.width, size.height * 0.35), paint);
    canvas.drawLine(Offset(0, size.height * 0.65),
        Offset(size.width / 2, size.height * 0.65), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WindDirectionCustomPainter extends CustomPainter {
  final Color color;

  const WindDirectionCustomPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const double height = 5;
    final paintBackground = Paint();
    paintBackground.color = color;
    paintBackground.style = PaintingStyle.stroke;
    paintBackground.strokeCap = StrokeCap.round;
    paintBackground.strokeWidth = size.height / 90;
    canvas.drawArc(
      Offset.zero & size,
      (-pi / 2) * 0.93,
      pi * 2 * 0.97,
      false,
      paintBackground,
    );
    final paintNorth = Paint();
    paintNorth.color = color;
    paintNorth.style = PaintingStyle.stroke;
    paintNorth.strokeCap = StrokeCap.round;
    paintNorth.strokeWidth = 6;
    canvas.drawCircle(
      Offset(size.width / 2, 0),
      6,
      paintNorth,
    );
    canvas.drawLine(
      Offset(size.width / 2, size.height + height),
      Offset(size.width / 2, size.height - height),
      paintNorth,
    );
    canvas.drawLine(
      Offset(0 - height, size.height / 2),
      Offset(height, size.height / 2),
      paintNorth,
    );
    canvas.drawLine(
      Offset(size.width + height, size.height / 2),
      Offset(size.width - height, size.height / 2),
      paintNorth,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WindArrowCustomPainter extends CustomPainter {
  final Color color;

  const WindArrowCustomPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const double arrowOdd = 10;
    const double arrowHeight = 10;
    const double limit = 15;
    final paintDir = Paint();
    paintDir.color = color;
    paintDir.style = PaintingStyle.stroke;
    paintDir.strokeCap = StrokeCap.round;
    paintDir.strokeWidth = 6;
    canvas.drawLine(
      Offset(size.width / 2, -limit),
      Offset(size.width / 2, size.height / 2 - limit * 2.5),
      paintDir,
    );
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2 + limit * 2.5),
      Offset(size.width / 2, size.height + limit),
      paintDir,
    );
    canvas.drawLine(
      Offset(size.width / 2, -limit),
      Offset(size.width / 2 + arrowOdd, arrowHeight),
      paintDir,
    );
    canvas.drawLine(
      Offset(size.width / 2, -limit),
      Offset(size.width / 2 - arrowOdd, arrowHeight),
      paintDir,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AirIndexScaleCustomPainter extends CustomPainter {
  final Color color;
  final double index;

  AirIndexScaleCustomPainter({
    super.repaint,
    required this.color,
    required this.index,
  });

  @override
  void paint(Canvas canvas, Size size) {

    double green = size.width/10;
    double yellow = green *2;
    double orange = green * 3;
    double red = green * 4;
    double purple = green * 6;
    double stroke = 0;
    double radius = 0;

    final greenLevel = Paint();
    greenLevel.color = Colors.lightGreenAccent;
    greenLevel.style = PaintingStyle.stroke;
    greenLevel.strokeCap = StrokeCap.round;
    greenLevel.strokeWidth = 3;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(green - stroke -radius, size.height / 2),
      greenLevel,
    );
    final yellowLevel = Paint();
    yellowLevel.color = Colors.yellowAccent;
    yellowLevel.style = PaintingStyle.stroke;
    yellowLevel.strokeCap = StrokeCap.round;
    yellowLevel.strokeWidth = 5;
    canvas.drawLine(
      Offset(green + stroke + radius, size.height / 2),
      Offset(yellow - stroke - radius, size.height / 2),
      yellowLevel,
    );
    final orangeLevel = Paint();
    orangeLevel.color = Colors.orangeAccent;
    orangeLevel.style = PaintingStyle.stroke;
    orangeLevel.strokeCap = StrokeCap.round;
    orangeLevel.strokeWidth = 7;
    canvas.drawLine(
      Offset(yellow + stroke+radius, size.height / 2),
      Offset(orange - stroke-radius, size.height / 2),
      orangeLevel,
    );
    final redLevel = Paint();
    redLevel.color = Colors.redAccent;
    redLevel.style = PaintingStyle.stroke;
    redLevel.strokeCap = StrokeCap.round;
    redLevel.strokeWidth = 9;
    canvas.drawLine(
      Offset(orange + stroke+ radius, size.height / 2),
      Offset(red - stroke-radius, size.height / 2),
      redLevel,
    );

    final purpleLevel = Paint();
    purpleLevel.color = Colors.purpleAccent;
    purpleLevel.style = PaintingStyle.stroke;
    purpleLevel.strokeCap = StrokeCap.round;
    purpleLevel.strokeWidth = 11;
    canvas.drawLine(
      Offset(red + stroke+radius, size.height / 2),
      Offset(purple - stroke-radius, size.height / 2),
      purpleLevel,
    );

    final brownLevel = Paint();
    brownLevel.color = Colors.brown;
    brownLevel.style = PaintingStyle.stroke;
    brownLevel.strokeCap = StrokeCap.round;
    brownLevel.strokeWidth = 13;
    canvas.drawLine(
      Offset(purple + stroke+radius, size.height / 2),
      Offset(size.width - stroke-radius, size.height / 2),
      brownLevel,
    );
    final paintCircle = Paint();
    paintCircle.color = color;
    paintCircle.style = PaintingStyle.fill;

    // canvas.drawCircle(Offset(green, size.height / 2), 2, paintCircle);
    // canvas.drawCircle(Offset(yellow, size.height / 2),2, paintCircle);
    // canvas.drawCircle(Offset(orange, size.height / 2),2, paintCircle);
    // canvas.drawCircle(Offset(red, size.height / 2), 2.5, paintCircle);
    // canvas.drawCircle(Offset(purple, size.height / 2), 3, paintCircle);

    final paintCircle1 = Paint();
    paintCircle1.color = color;
    paintCircle1.style = PaintingStyle.stroke;
    paintCircle1.strokeCap = StrokeCap.round;
    paintCircle1.strokeWidth = 3;

    canvas.drawLine(
      Offset(size.width/500 * index , size.height / 2 - 15),
      Offset(size.width/500 * index , size.height / 2 + 15),
      paintCircle1,
    );
    canvas.drawCircle(
      Offset(size.width/500 * index , size.height / 2 - 15 - 5), 5,
      paintCircle1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

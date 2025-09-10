import 'dart:math';
import 'package:flutter/material.dart';

class ArrowCustomPainter extends CustomPainter {
  final Color? color;

  ArrowCustomPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color ?? Colors.black;
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
  DoubleLineCustomPainter();

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
    double greenX = size.width / 10;
    double yellowX = greenX * 2;
    double orangeX = greenX * 3;
    double redX = greenX * 4;
    double purpleX = greenX * 6;
    double stroke = 0;
    double radius = 0;

    final greenLevel = Paint();
    greenLevel.color = Colors.green[600]!;
    greenLevel.style = PaintingStyle.stroke;
    greenLevel.strokeCap = StrokeCap.round;
    greenLevel.strokeWidth = 3;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(greenX - stroke - radius, size.height / 2),
      greenLevel,
    );
    final yellowLevel = Paint();
    yellowLevel.color = Colors.amber[600]!;
    yellowLevel.style = PaintingStyle.stroke;
    yellowLevel.strokeCap = StrokeCap.round;
    yellowLevel.strokeWidth = 5;
    canvas.drawLine(
      Offset(greenX + stroke + radius, size.height / 2),
      Offset(yellowX - stroke - radius, size.height / 2),
      yellowLevel,
    );
    final orangeLevel = Paint();
    orangeLevel.color = Colors.orange[600]!;
    orangeLevel.style = PaintingStyle.stroke;
    orangeLevel.strokeCap = StrokeCap.round;
    orangeLevel.strokeWidth = 7;
    canvas.drawLine(
      Offset(yellowX + stroke + radius, size.height / 2),
      Offset(orangeX - stroke - radius, size.height / 2),
      orangeLevel,
    );
    final redLevel = Paint();
    redLevel.color = Colors.red[600]!;
    redLevel.style = PaintingStyle.stroke;
    redLevel.strokeCap = StrokeCap.round;
    redLevel.strokeWidth = 9;
    canvas.drawLine(
      Offset(orangeX + stroke + radius, size.height / 2),
      Offset(redX - stroke - radius, size.height / 2),
      redLevel,
    );

    final purpleLevel = Paint();
    purpleLevel.color = Colors.deepPurple[600]!;
    purpleLevel.style = PaintingStyle.stroke;
    purpleLevel.strokeCap = StrokeCap.round;
    purpleLevel.strokeWidth = 11;
    canvas.drawLine(
      Offset(redX + stroke + radius, size.height / 2),
      Offset(purpleX - stroke - radius, size.height / 2),
      purpleLevel,
    );

    final brownLevel = Paint();
    brownLevel.color = Colors.brown[600]!;
    brownLevel.style = PaintingStyle.stroke;
    brownLevel.strokeCap = StrokeCap.round;
    brownLevel.strokeWidth = 13;
    canvas.drawLine(
      Offset(purpleX + stroke + radius, size.height / 2),
      Offset(size.width - stroke - radius, size.height / 2),
      brownLevel,
    );
    final paintCircle = Paint();
    paintCircle.color = color;
    paintCircle.style = PaintingStyle.fill;

    // canvas.drawCircle(Offset(greenX, size.height / 2), 2, paintCircle);
    // canvas.drawCircle(Offset(yellowX, size.height / 2),2, paintCircle);
    // canvas.drawCircle(Offset(orangeX, size.height / 2),2, paintCircle);
    // canvas.drawCircle(Offset(redX, size.height / 2), 2.5, paintCircle);
    // canvas.drawCircle(Offset(purpleX, size.height / 2), 3, paintCircle);

    final paintCircle1 = Paint();
    paintCircle1.color = color;
    paintCircle1.style = PaintingStyle.stroke;
    paintCircle1.strokeCap = StrokeCap.round;
    paintCircle1.strokeWidth = 3;

    canvas.drawLine(
      Offset(size.width / 500 * index, size.height / 2 - 15),
      Offset(size.width / 500 * index, size.height / 2 + 15),
      paintCircle1,
    );
    canvas.drawCircle(
      Offset(size.width / 500 * index, size.height / 2 - 15 - 5),
      5,
      paintCircle1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class UvIndexCustomPainter extends CustomPainter {
  final Color color;
  final double index;

  UvIndexCustomPainter({
    super.repaint,
    required this.color,
    required this.index,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double first = size.width / 11;
    double stroke = 5;
    final paintBg = Paint();
    paintBg.color = color;
    paintBg.style = PaintingStyle.fill;
    paintBg.strokeCap = StrokeCap.round;
    paintBg.strokeWidth = stroke;
    for (var i = 0; i <= 11; i++) {
      final paint = Paint();
      paint.color = getIndexColor(i)!;
      paint.style = i > index ? PaintingStyle.fill : PaintingStyle.stroke;
      paint.strokeCap = StrokeCap.round;
      paint.strokeWidth = stroke;
      if (i <= index) {
        canvas.drawCircle(Offset(first * i, size.height / 2), 10, paintBg);
      }
      canvas.drawCircle(Offset(first * i, size.height / 2), 10, paint);
    }
  }

  Color? getIndexColor(int index) {
    if (index < 2) return Colors.green[600];
    if (index < 3) return Colors.amber[600];
    if (index < 6) return Colors.deepOrange[600];
    if (index < 9) return Colors.red[600];
    return Colors.deepPurple[600];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

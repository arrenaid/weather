import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';

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

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
    paint.strokeWidth = size.height / 10;
    canvas.drawLine(
        Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.35), paint);
    canvas.drawLine(
        Offset(0, size.height * 0.65), Offset(size.width/2, size.height * 0.65), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
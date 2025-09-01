import 'package:flutter/material.dart';
import 'arrow_paint.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton(
      {super.key,
      required this.execute,
      this.isNotArrow = false,
      this.width = 50,
      this.height = 25});

  final GestureTapCallback execute;
  final bool isNotArrow;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: execute,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      child: CustomPaint(
        size: Size(width, height),
        painter: isNotArrow ? DoubleLineCustomPainter() : ArrowCustomPainter(),
      ),
    );
  }
}

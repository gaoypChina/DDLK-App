import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:flutter/material.dart';

class LineDashedPainter extends CustomPainter {
  bool isHorizontal;
  Color color;
  LineDashedPainter({
    this.isHorizontal = true,
    this.color = ColorConstant.neutral_gray_lighter,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.strokeWidth = 1;
    paint.color = color;

    var dashWidth = 6;
    var dashSpace = 4;
    double startY = 10;
    double startX = 10;
    if (isHorizontal) {
      while (startY < size.height - 10) {
        canvas.drawLine(
            Offset(0, startY), Offset(0, startY + dashWidth), paint);
        final space = (dashSpace + dashWidth);
        startY += space;
      }
    } else {
      while (startX < size.width - 10) {
        canvas.drawLine(
            Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        final space = (dashSpace + dashWidth);
        startX += space;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashSpace;
  final Color color;

  DashedLinePainter({
    this.dashHeight = 5,
    this.dashSpace = 3,
    this.color = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

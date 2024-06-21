import 'package:flutter/material.dart';


class CustomCircularProgressIndicator extends StatelessWidget {
  final double value;

  CustomCircularProgressIndicator({required this.value});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(50, 50),
      painter: _CustomCircularProgressPainter(value),
    );
  }
}

class _CustomCircularProgressPainter extends CustomPainter {
  final double value;

  _CustomCircularProgressPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 6.0
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paint);
    paint.color = Colors.red;
    double sweepAngle = 2 * 3.141592653589793 * value;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -3.141592653589793 / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

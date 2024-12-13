import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width, size.height);
    path_0.lineTo(size.width * 0.0012500, size.height * 0.9942857);
    path_0.lineTo(size.width * 0.0012500, size.height * 0.4271429);
    path_0.quadraticBezierTo(size.width * 0.0740625, size.height * 0.2807143,
        size.width * 0.1950000, size.height * 0.2800000);
    path_0.quadraticBezierTo(size.width * 0.8515625, size.height * 0.3560714,
        size.width * 0.9962500, size.height * 0.2828571);
    path_0.quadraticBezierTo(size.width * 0.9990625, size.height * 0.2850000,
        size.width, size.height * 0.2857143);
    path_0.quadraticBezierTo(size.width * 1.0084375, size.height * 0.4992857,
        size.width, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
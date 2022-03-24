import 'package:flutter/material.dart';

class AuthenticationPageBackground extends CustomPainter{
  Color color;
  AuthenticationPageBackground({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    drawHeader(canvas, size);
    //drawSide(canvas, size);
    //drawFooter(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

 drawHeader(Canvas canvas, Size size) {
   double width = size.width;
   double height = size.height;
   Paint headerPaint = Paint()
     ..style = PaintingStyle.fill
     ..color = color;
   Path headerPath = Path();
   headerPath.quadraticBezierTo(
       width * 0.1, height * 0.3, width * 0.5, height * 0.3);
   headerPath.quadraticBezierTo(width * 0.9, height * 0.3, width, 0);
   canvas.drawPath(headerPath, headerPaint);
 }

  // @override
  // drawFooter(Canvas canvas, Size size) {
  //   double width = size.width;
  //   double height = size.height;
  //   Paint footerPaint = Paint()
  //     ..style = PaintingStyle.fill
  //     ..color = color;
  //   Path footerPath = Path();
  //   footerPath.moveTo(width * 0.5, height);
  //   footerPath.quadraticBezierTo(
  //       width * 0.62, height * 0.84, width * 0.75, height * 0.78);
  //   footerPath.quadraticBezierTo(
  //       width * 0.875, height * 0.73, width, height * 0.73);
  //   footerPath.quadraticBezierTo(width, height, width, height);
  //   canvas.drawPath(footerPath, footerPaint);
  // }
  //
  // @override
  // drawHeader(Canvas canvas, Size size) {
  //   double width = size.width;
  //   double height = size.height;
  //   Paint headerPaint = Paint()
  //     ..style = PaintingStyle.fill
  //     ..color = color;
  //   Path headerPath = Path();
  //   headerPath.quadraticBezierTo(
  //       width * 0.1, height * 0.3, width * 0.5, height * 0.3);
  //   headerPath.quadraticBezierTo(width * 0.9, height * 0.3, width, 0);
  //   canvas.drawPath(headerPath, headerPaint);
  // }
  //
  // @override
  // drawSide(Canvas canvas, Size size) {
  //   double width = size.width;
  //   double height = size.height;
  //   Path sidePath = Path();
  //   Paint sidePaint = Paint()
  //     ..style = PaintingStyle.fill
  //     ..color = color;
  //   sidePath.moveTo(0, height * 0.4);
  //   sidePath.quadraticBezierTo(
  //       width * 0.25, height * 0.42, width * 0.3, height * 0.5);
  //   sidePath.quadraticBezierTo(width * 0.35, height * 0.6, 0, height * 0.65);
  //
  //   canvas.drawPath(sidePath, sidePaint);
  // }
}

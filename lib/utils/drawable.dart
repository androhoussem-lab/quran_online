import 'package:flutter/material.dart';


abstract class Drawable {
  drawHeader(Canvas canvas,Size size);
  drawSide(Canvas canvas,Size size);
  drawFooter(Canvas canvas,Size size);
}
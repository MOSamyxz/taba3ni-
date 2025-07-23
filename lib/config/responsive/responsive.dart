// lib/core/utils/responsive.dart

import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  final double _width;
  final double _height;

  Responsive(this.context)
      : _width = MediaQuery.of(context).size.width,
        _height = MediaQuery.of(context).size.height;

  double wp(double percent) => _width * percent / 100;       // Width Percent
  double hp(double percent) => _height * percent / 100;      // Height Percent
  double sp(double scale) => _width * scale / 100;           // Font Size
  double radius(double percent) => _width * percent / 100;   // Border Radius
  double padding(double percent) => _width * percent / 100;  // Padding or Margin
}

//#GROUP_TEMPLATE theme
import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

var bgColor = const Color(0xFF212332);
var defaultPadding = 16.0;

var successColor = Colors.green[300]!;
var infoColor = Colors.blue[300]!;
var warningColor = Colors.orange[300]!;
var disabledColor = Colors.grey[300]!;

var disabledTextColor = Colors.grey[800];

class AppSize {
  static const double s08 = 0.8;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s30 = 30.0;
  static const double s36 = 36.0;
  static const double s40 = 40.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s70 = 70.0;
  static const double s100 = 100.0;
  static const double s150 = 150.0;
  static const double s200 = 200.0;
  static const double s250 = 250.0;
}

double get sizeHeight {
  return MediaQuery.of(globalContext).size.height;
}

double get sizeWidth {
  return MediaQuery.of(globalContext).size.width;
}
